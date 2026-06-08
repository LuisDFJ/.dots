mod hsl;
mod cpu;
mod memory;
mod disk;
mod network;
mod time;
mod battery;
mod audio;

use std::io;

use crate::cpu::cpu_info;
use crate::memory::memory_info;
use crate::disk::disk_info;
use crate::network::network_info;
use crate::time::time_info;
use crate::battery::battery_info;

use std::env;
fn main() -> io::Result<()>{
    let args : Vec<String> = env::args().collect();
    for arg in args {
        match arg.as_str() {
            "cpu"       => {println!("{}", cpu_info()); break},
            "memory"    => {println!("{}", memory_info()); break},
            "disk"      => {println!("{}", disk_info()); break},
            "network"   => {println!("{}", network_info()); break},
            "battery"   => {println!("{}", battery_info()); break},
            "time"      => {println!("{}", time_info()); break},
            _ => {},
        }
    }
    Ok(())
}
