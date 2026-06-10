use std::process::Command;

#[derive(Debug)]
struct NetworkInfo {
    ssid : String,
    signal : u32,
    rate : String
}

fn parse_signal(val : u32) -> String {
    match val {
        v if v < 20  => "\u{f092f}",
        v if v < 40  => "\u{f091f}",
        v if v < 60  => "\u{f0922}",
        v if v < 80  => "\u{f0925}",
        v if v < 100 => "\u{f0928}",
        _ => " ",
    }.to_string()
}

fn parse_network() -> Option<NetworkInfo> {
    let output = Command::new("nmcli")
        .args(["-t", "-f", "IN-USE,SSID,SIGNAL,RATE", "dev", "wifi", "list"])
        .output();
    if let Ok(output) = output {
        let stdout = String::from_utf8_lossy(&output.stdout);
        for line in stdout.split('\n') {
            if line.starts_with("*") {
                let fields : Vec<&str> = line.split(':').collect();
                if fields.len() == 4 {
                    return Some(NetworkInfo{
                        ssid : fields[1].to_string(),
                        signal : fields[2].parse::<u32>().unwrap_or(0),
                        rate : fields[3].to_string()
                    });
                }
            }
        }
    }
    return None
}

use crate::cpu::map_color;
pub fn network_info( theme : bool ) -> String {
    let netinfo = parse_network();

    let mut res = String::new();
    if let Some(info) = netinfo {
        res = format!("NET {} {} {} \u{f03d5}",
            info.ssid,
            map_color( info.signal as f32 / 100., parse_signal( info.signal ).as_str(), true, theme ),
            info.rate,
        )
    }
    res
}
