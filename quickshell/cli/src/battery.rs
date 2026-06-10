use std::fs;

enum BatteryStatus {
    Charging,
    Uncharging,
    Unknown
}

struct BatteryInfo {
    capacity : u32,
    status : BatteryStatus
}

impl BatteryStatus {
    fn parse( s : &str ) -> Self {
        match s.trim() {
            "uncharging" => BatteryStatus::Uncharging,
            "charging" => BatteryStatus::Charging,
            _ => BatteryStatus::Unknown
        }
    }
}

impl BatteryInfo {
    fn new() -> Self {
        let capacity = fs::read_to_string("/sys/class/power_supply/BAT0/capacity")
            .unwrap_or("0".to_string())
            .trim()
            .parse::<u32>()
            .unwrap_or(0);
        let status = fs::read_to_string("/sys/class/power_supply/BAT0/status")
            .unwrap_or("Unknown".to_string());
        BatteryInfo {
            capacity,
            status: BatteryStatus::parse(&status.to_lowercase())
        }
    }
    fn icon(&self) -> String {
        match self.status {
            BatteryStatus::Charging => {
                match self.capacity {
                    c if c < 10 => "\u{f089c}",
                    c if c < 20 => "\u{f0086}",
                    c if c < 30 => "\u{f0087}",
                    c if c < 40 => "\u{f0088}",
                    c if c < 50 => "\u{f089d}",
                    c if c < 60 => "\u{f0089}",
                    c if c < 70 => "\u{f089e}",
                    c if c < 80 => "\u{f008a}",
                    c if c < 90 => "\u{f008b}",
                    c if c < 100=> "\u{f0085}",
                    _ => ""
                }
            },
            _ => {
                match self.capacity {
                    c if c < 10 => "\u{f007a}",
                    c if c < 20 => "\u{f007b}",
                    c if c < 30 => "\u{f007c}",
                    c if c < 40 => "\u{f007d}",
                    c if c < 50 => "\u{f007e}",
                    c if c < 60 => "\u{f007f}",
                    c if c < 70 => "\u{f0080}",
                    c if c < 80 => "\u{f0081}",
                    c if c < 90 => "\u{f0082}",
                    c if c < 100=> "\u{f0079}",
                    _ => ""
                }
            }
        }.to_string()
    }
}

use crate::disk::map_color;
pub fn battery_info( theme : bool ) -> String {
    let info = BatteryInfo::new();
    format!("{} {}", info.icon(), map_color(info.capacity as f32 / 100., false, theme) )
}
