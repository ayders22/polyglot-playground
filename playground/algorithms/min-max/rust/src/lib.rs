pub fn find_min_max_builtin(values: &[i32]) -> Option<(i32, i32)> {
    if values.is_empty() {
        return None;
    }

    let min = *values.iter().min().unwrap();
    let max = *values.iter().max().unwrap();

    Some((min, max))
}

pub fn find_min_max_manual(values: &[i32]) -> Option<(i32, i32)> {
    if values.is_empty() {
        return None;
    }

    let mut min = values[0];
    let mut max = values[0];

    for &value in values.iter() {
        if value < min {
            min = value;
        }
        if value > max {
            max = value;
        }
    }

    Some((min, max))
}
