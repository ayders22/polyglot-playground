use min_max::{find_min_max_builtin, find_min_max_manual};

#[test]
fn find_min_max_builtin_returns_correct_min_and_max() {
    assert_eq!(find_min_max_builtin(&[1, 2, 3, 4, 5]), Some((1, 5)));
}

#[test]
fn find_min_max_manual_returns_correct_min_and_max() {
    assert_eq!(find_min_max_manual(&[1, 2, 3, 4, 5]), Some((1, 5)));
}
