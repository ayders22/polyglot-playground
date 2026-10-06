class EvenIterator:
    def __init__(self, data):
        self.data = data
        self.index = 0

    def __iter__(self):
        return self

    def __next__(self):
        while self.index < len(self.data):
            value = self.data[self.index]
            self.index += 1
            if value % 2 == 0:
                return value
        raise StopIteration