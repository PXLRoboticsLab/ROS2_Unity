import rclpy
from rclpy.node import Node

from simkart_interfaces.msg import KartControl


class KartPublisher(Node):

    def __init__(self):
        super().__init__('kart_publisher')
        self.turn = 0.3
        self.publisher_ = self.create_publisher(KartControl, 'kart_ctrl', 10)
        timer_period = 0.2
        self.timer = self.create_timer(timer_period, self.timer_callback)
        self.steeringSwitchTimer = self.create_timer(2, self.turn_callback) #switch steering side each x seconds

    def turn_callback(self):
        self.turn *= -1

    def timer_callback(self):
        msg = KartControl()                                           
        msg.acceleration = 1.0
        msg.steering = self.turn
        msg.brake = 0.0
        self.publisher_.publish(msg)


def main(args=None):
    rclpy.init(args=args)

    kart_publisher = KartPublisher()

    rclpy.spin(kart_publisher)

    kart_publisher.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()