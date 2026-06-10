use sysinfo::Disks;
use crate::hsl::{HSL,RGB};

pub fn map_color( val : f32, f : bool, theme : bool ) -> String {
    let col = HSL::new(180.* if f { 1.-val } else {val},1.0, if theme {0.25} else {0.5} );
    format!("<font color=\"{}\">{:.0}%</font>", RGB::from_hsl(col).to_string(), val*100.)
}

pub fn disk_info( theme : bool ) -> String {
    let scale = (1024*1024*1024) as f32;
    let disks = Disks::new_with_refreshed_list();
    let disk = disks.iter().find(|d| d.mount_point() == "/").unwrap();
    let t_space = disk.total_space() as f32 / scale;
    let a_space = disk.available_space() as f32 / scale;
    let u_space = t_space - a_space;
    format!("{:05.2}/{:05.2} GB ({})",
        u_space,t_space,map_color(u_space/t_space, true, theme)
    )
}
