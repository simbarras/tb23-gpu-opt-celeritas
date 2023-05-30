# Compute the resistance of a bridge circuit
#
#        |-- 24V ------|    |--------- 0-5V -------|
#        |            blue black                   |
#        +             |    |                     R1
# ****************  **********                     |         *******
# * Alimentation *  * Sensor *  Vout (Max 3,5V) -->|-- A0 -- * ADC *
# ****************  **********                     |         *******
#        -             |                          R2            |
#        |           Brown                         |            |
#        |-- GND ------|---------------------------|------------|
#
# R1 + R2 ~= 10-20 kOhm
#
#
#         Vin * R1
# Vout = ----------
#         R1  + R2

possible_resistors = [3300, 4700, 5600, 6800, 8200, 10000, 12000, 15000, 18000]
max_vin = 5.0
max_vout = 3.5
min_r = 10000
max_r = 20000
possible_coupling = []


def compute_resistance(vin, r1, r2):
    return (vin * r1) / (r1 + r2)


def find_resistors():
    for r1 in possible_resistors:
        for r2 in possible_resistors:
            if min_r <= r1 + r2 <= max_r:
                vout = compute_resistance(max_vin, r1, r2)
                if vout <= max_vout:
                    possible_coupling.append((r1, r2, vout))

    return possible_coupling


def print_resistors(nb):
    for i in range(nb):
        print("R1: " + str(possible_coupling[i][0]) +
             " R2: " + str(possible_coupling[i][1]) +
             " Vout: " + str(
            possible_coupling[i][2]))


def main():
    couples = find_resistors()
    couples.sort(key=lambda x: x[2], reverse=True)
    print_resistors(5)


if __name__ == "__main__":
    main()
