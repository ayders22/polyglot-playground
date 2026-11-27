use std::hint::black_box;

use criterion::{criterion_group, criterion_main, Criterion};
use hello_world::{hello_world_impl1, hello_world_impl2};

fn benchmark_hello_world(criterion: &mut Criterion) {
    let mut group = criterion.benchmark_group("hello_world");

    group.bench_function("hello_world_impl1", |bencher| {
        bencher.iter(|| black_box(hello_world_impl1()));
    });
    group.bench_function("hello_world_impl2", |bencher| {
        bencher.iter(|| black_box(hello_world_impl2()));
    });
}

criterion_group!(benches, benchmark_hello_world);
criterion_main!(benches);
