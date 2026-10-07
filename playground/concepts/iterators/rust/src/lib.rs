pub struct Evens<'a> {
    pub data: &'a [i32],
    index: usize,
}

impl<'a> Evens<'a> {
    pub fn new(data: &'a [i32]) -> Self {
        Self { data, index: 0 }
    }
}

impl<'a> Iterator for Evens<'a> {
    type Item = i32;

    fn next(&mut self) -> Option<Self::Item> {
        while self.index < self.data.len() {
            let n = self.data[self.index];
            self.index += 1;

            if n % 2 == 0 {
                return Some(n);
            }
        }

        None
    }
}
