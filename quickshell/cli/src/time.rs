use chrono::{Local};

pub fn time_info() -> String {
    let local_time = Local::now();
    local_time.format("%Y-%m-%d \u{eab0} %H:%M:%S \u{f017}").to_string()
}
