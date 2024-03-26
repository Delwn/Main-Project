#!/usr/bin/python
import time
import smbus
import math
import os
import csv

# Register
power_mgmt_1 = 0x6b
power_mgmt_2 = 0x6c

def read_byte(reg):
    return bus.read_byte_data(address, reg)

def read_word(reg):
    h = bus.read_byte_data(address, reg)
    l = bus.read_byte_data(address, reg+1)
    value = (h << 8) + l
    return value

def read_word_2c(reg):
    val = read_word(reg)
    if (val >= 0x8000):
        return -((65535 - val) + 1)
    else:
        return val

def dist(a,b):
    return math.sqrt((a*a)+(b*b))

def get_y_rotation(x,y,z):
    radians = math.atan2(x, dist(y,z))
    return -math.degrees(radians)

def get_x_rotation(x,y,z):
    radians = math.atan2(y, dist(x,z))
    return math.degrees(radians)

bus = smbus.SMBus(1)
address = 0x68       # via i2cdetect

# Start the bus to send request for data.
bus.write_byte_data(address, power_mgmt_1, 0)


file_g = open("gyro.csv", "w", newline="")
file_a = open("acc.csv", "w", newline="")
writer_g = csv.writer(file_g)
writer_a = csv.writer(file_a)
acce_data = ["x", "y", "z"]
writer_g.writerow(acce_data)
writer_a.writerow(acce_data)
i = 0
while True:
        print("\n" + i)
        print("Gyroscope")
        print("--------")

        gyroscope_x = read_word_2c(0x43) - (-0.47780152671755716)
        gyroscope_y = read_word_2c(0x45) - 0.23638167938931298
        gyroscope_z = read_word_2c(0x47) - (-0.7384580152671756)



        print("gyroscope_x: ", ("%5d" % gyroscope_x), " scaled: ", (gyroscope_x / 131))
        print("gyroscope_y: ", ("%5d" % gyroscope_y), " scaled: ", (gyroscope_y / 131))
        print("gyroscope_z: ", ("%5d" % gyroscope_z), " scaled: ", (gyroscope_z / 131))
        
        
        writer_g.writerow([gyroscope_x / 131, gyroscope_y / 131, gyroscope_z/ 131])

        print("Acceleratometer")
        print("---------------------")

        acceleration_x = read_word_2c(0x3b)
        acceleration_y = read_word_2c(0x3d)
        acceleration_z = read_word_2c(0x3f)

        acceleration_x_scaled = acceleration_x / 16384.0
        acceleration_y_scaled = acceleration_y / 16384.0
        acceleration_z_scaled = acceleration_z / 16384.0

        print("acceleration_x: ", ("%6d" % acceleration_x), " scaled: ", acceleration_x_scaled)
        print("acceleration_y: ", ("%6d" % acceleration_y), " scaled: ", acceleration_y_scaled)
        print("acceleration_z: ", ("%6d" % acceleration_z), " scaled: ", acceleration_z_scaled)

        writer_a.writerow([acceleration_x_scaled, acceleration_y_scaled, acceleration_z_scaled])
        print("\n\n")
        i += 1
        time.sleep(0.5)

