use std::hint::black_box;

use criterion::{criterion_group, criterion_main, Criterion};
use min_max::{find_min_max_builtin, find_min_max_manual};

fn benchmark_min_max(criterion: &mut Criterion) {
    let values: Vec<i32> = (0..10_000).map(|index| (index * 7_919) % 10_000).collect();
    let mut group = criterion.benchmark_group("min_max");

    group.bench_function("find_min_max_builtin", |b| {
        b.iter(|| black_box(find_min_max_builtin(black_box(&values))));
    });
    group.bench_function("find_min_max_manual", |b| {
        b.iter(|| black_box(find_min_max_manual(black_box(&values))));
    });
}

criterion_group!(benches, benchmark_min_max);
criterion_main!(benches);
