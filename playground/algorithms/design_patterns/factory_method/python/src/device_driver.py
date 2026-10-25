from abc import ABC, abstractmethod


class DeviceDriver(ABC):
    @abstractmethod
    def open(self) -> bool:
        pass
