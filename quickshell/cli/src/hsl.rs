pub struct HSL {
    h : f32,
    s : f32,
    l : f32,
}

pub struct RGB {
    r : u8,
    g : u8,
    b : u8,
}

fn clip( v : f32, a : f32, b : f32 ) -> f32 {
    v.max(a).min(b)
}

impl HSL {
    pub fn new( h : f32, s : f32, l : f32 ) -> Self {
        let h = clip(h,0.,360.);
        let s = clip(s,0.,1.);
        let l = clip(l,0.,1.);
        Self {h,s,l}
    }
}

impl RGB {
    pub fn new( r : u8, g : u8, b : u8 ) -> Self {
        Self {r,g,b}
    }
    pub fn to_string( self : &Self ) -> String {
       format!("#{:02x}{:02x}{:02x}", self.r, self.g, self.b)
    }
    pub fn from_hsl( hsl : HSL ) -> Self {
        let c = (1. - (2.*hsl.l - 1.).abs())*hsl.s;
        let x = c*(1. - ((hsl.h/60.).rem_euclid(2.) - 1.).abs());
        let m = hsl.l - c / 2.;
        let rgb = match hsl.h {
            h if h < 60.  => (c,x,0.),
            h if h < 120. => (x,c,0.),
            h if h < 180. => (0.,c,x),
            h if h < 240. => (0.,x,c),
            h if h < 300. => (x,0.,c),
            h if h < 360. => (c,0.,x),
            _ => (0.,0.,0.),
        };
        Self::new(
            (( rgb.0 + m ) * 255.) as u8,
            (( rgb.1 + m ) * 255.) as u8,
            (( rgb.2 + m ) * 255.) as u8,
        )
    }
}
