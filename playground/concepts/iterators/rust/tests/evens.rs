use iterators::Evens;

#[test]
fn custom_iterator_happy_path() {
    let evens = Evens::new(&[1, 2, 3, 4, 5, 6]);

    let mut even_numbers = Vec::<i32>::new();
    for n in evens {
        even_numbers.push(n);
    }

    assert_eq!(even_numbers, [2, 4, 6]);
}

#[test]
fn custom_iterator_empty_input() {
    let evens = Evens::new(&[]);

    let mut even_numbers = Vec::<i32>::new();
    for n in evens {
        even_numbers.push(n);
    }

    assert_eq!(even_numbers, []);
}

#[test]
fn custom_iterator_filter_collect() {
    let evens = Evens::new(&[1, 2, 3, 4, 5, 6]);
    let filtered_evens: Vec<_> = evens.filter(|n| n > &2).collect();

    assert_eq!(filtered_evens, [4, 6]);
}
