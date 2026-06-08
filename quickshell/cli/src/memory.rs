use sysinfo::System;
use crate::disk::map_color;

pub fn memory_info() -> String {
    let mut sys = System::new();
    sys.refresh_all();
    let scale = ( 1024 * 1024 * 1024 ) as f32;
    let u_mem = sys.used_memory() as f32 / scale;
    let t_mem = sys.total_memory() as f32 / scale;
    let u_swp = sys.used_swap() as f32 / scale;
    let t_swp = sys.total_swap() as f32 / scale;
    format!("MEM {:05.2}/{:05.2} ({}) GB | SWP {:05.2}/{:05.2} GB ({})",
        u_mem,t_mem,map_color(u_mem/t_mem,true),
        u_swp,t_swp,map_color(u_swp/t_swp,true)
    )
}
