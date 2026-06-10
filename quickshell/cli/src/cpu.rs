use sysinfo::System;
use crate::hsl::{HSL,RGB};

pub fn map_color( val : f32, s : &str, f : bool, theme : bool ) -> String {
    let col = HSL::new( 180.* if f { val } else {1.-val},1.0, if theme { 0.25 } else { 0.5 } );
    format!("<font color=\"{}\">{}</font>", RGB::from_hsl(col).to_string(), s)
}

fn map_char( val : f32 ) -> &'static str {
     match val {
        f if f < 1./8. => "\u{2581}",
        f if f < 2./8. => "\u{2582}",
        f if f < 3./8. => "\u{2583}",
        f if f < 4./8. => "\u{2584}",
        f if f < 5./8. => "\u{2585}",
        f if f < 6./8. => "\u{2586}",
        f if f < 7./8. => "\u{2587}",
        f if f < 8./8. => "\u{2588}",
        _ => " ",
    }
}

pub fn cpu_info( theme : bool ) -> String {
    let max_cpu_freq = 4600;
    let mut sys = System::new();
    sys.refresh_all();
    let (sum, count) = sys.cpus().into_iter()
        .fold((0,0), |(s,c), x| (s+x.frequency(), c+1));
    let mut res = format!("{} MHz ", sum / count );
    for cpu in sys.cpus() {
        let freq =cpu.frequency() as f32 / max_cpu_freq as f32;
        res = res + map_color(freq,map_char(freq),false,theme).as_str();
    }
    res
}
