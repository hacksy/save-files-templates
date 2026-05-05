meta:
    id: wario_land_save_file
    title: Wario Land - Super Mario Land 3 (World) Save File
    license: CC0-1.0
    file-extension: sav
    endian: le
    bit-endian: le
    xref:
        game-name: Wario Land - Super Mario Land 3 (World)
        game-no-intro-id: 1480
        game-size: 524288
        game-crc: 40be3889
        game-md5: d9d957771484ef846d4e8d241f6f2815
seq:
    - id: slot_1
      type: slot_set
    - id: slot_2
      type: slot_set
    - id: slot_3
      type: slot_set

    - id: checksum_1
      type: checksum
      doc: Checksum for slot 1

    - id: checksum_2
      type: checksum
      doc: Checksum for slot 2

    - id: checksum_3
      type: checksum
      doc: Checksum for slot 3

    - id: selected_slot
      type: u1
      doc: Currently selected slot (0, 1, or 2)

types:
    slot_set:
        seq:
            - id: slot
              type: slots
            - id: mirror
              type: slots
    magic:
        seq:
            - id: magic
              contents: [ 0x19, 0x64, 0x39, 0x57 ]

    u1bcd:
        seq:
            - id: b1
              type: u1
        instances:
            value:
                value: |
                    ((b1 >> 4) & 0xF) * 10 + (b1 & 0xF)

    u3bcd_be:
        seq:
            - id: b1
              type: u1
            - id: b2
              type: u1
            - id: b3
              type: u1
        instances:
            value:
                value: |
                    ((b3 >> 4) & 0xF) * 10 + (b3 & 0xF) +
                    ((b2 >> 4) & 0xF) * 1000 + (b2 & 0xF) * 100 +
                    ((b1 >> 4) & 0xF) * 100000 + (b1 & 0xF) * 10000  
    world_status:
        params:
            - id: count
              type: u1
        seq:
            - id: world_status
              type: b1
              repeat: expr
              repeat-expr: count

    treasure_status:
        params:
            - id: offset
              type: u1
            - id: count
              type: u1

        seq:
            - id: skip
              type: b1
              repeat: expr
              repeat-expr: offset

            - id: treasure_status
              type: b1
              repeat: expr
              repeat-expr: count

    slots:
        seq:
            - id: magic
              type: magic
              size: 4

            - id: current_course
              type: u1
              enum: courses
              doc: Location of Wario in the World Map

            - id: coins
              type: u3bcd_be
              size: 3
              doc: Total number of coins collected by Wario
              valid:
                  expr: (coins.value >= 0) and (coins.value <= 99999)

            - id: hearts
              type: u1bcd
              size: 1
              doc: Current hearts collected by Wario
              valid:
                  expr: (hearts.value >= 0) and (hearts.value <= 99)

            - id: lives
              type: u1bcd
              size: 1
              doc: How many lives Wario has remaining
              valid:
                  expr: (lives.value >= 0) and (lives.value <= 99)

            - id: current_powerup
              type: u1
              enum: powerups
              doc: Wario's current power-up state

            - id: rice_beach_courses
              type: world_status(7)
              size: 1
              doc: Status of courses in Rice Beach

            - id: mt_teapot_courses
              type: world_status(8)
              size: 1
              doc: Status of courses in Mt. Teapot

            - id: course_count
              type: u1
              doc: Number of courses completed

            - id: treasure_set_a
              type: treasure_status(1,7)
              size: 1
              doc: Set of treasures

            - id: treasure_set_b
              type: treasure_status(0,8)
              size: 1
              doc: Set of treasures

            - id: stove_canyon_courses
              type: world_status(7)
              size: 1
              doc: Status of courses in Stove Canyon

            - id: ss_tea_cup_courses
              type: world_status(5)
              size: 1
              doc: Status of courses in SS Tea Cup

            - id: parsley_woods_courses
              type: world_status(6)
              size: 1
              doc: Status of courses in Parsley Woods

            - id: sherbet_island_courses
              type: world_status(8)
              size: 1
              doc: Status of courses in Sherbet Island

            - id: syrup_castle_courses
              type: world_status(3)
              size: 1
              doc: Status of courses in Syrup Castle

            - id: checkpoint_status
              type: b1
              doc: Checkpoint selected

            - id: checkpoint_level
              type: u1
              enum: courses
              doc: Current Checkpoint

            - id: progression
              type: u1
              enum: progression
              doc: Overall game progression

            - id: unused
              type: u1
              repeat: expr
              repeat-expr: 8

    checksum:
        seq:
            - id: checksum
              type: u1
              doc: Checksum of the 20 bytes of slot data , converted to ubyte
enums:
    courses:
        0x0:
            id: course_26
        0x1:
            id: course_33
        0x2:
            id: course_15
        0x3:
            id: course_20
        0x4:
            id: course_16
        0x5:
            id: course_10
        0x6:
            id: course_07
        0x7:
            id: course_01
        0x8:
            id: course_17
        0x9:
            id: course_12
        0xa:
            id: course_13
        0xb:
            id: course_29
        0xc:
            id: course_04
        0xd:
            id: course_09
        0xe:
            id: course_03
        0xf:
            id: course_02
        0x10:
            id: course_08
        0x11:
            id: course_11
        0x12:
            id: course_35
        0x13:
            id: course_34
        0x14:
            id: course_30
        0x15:
            id: course_21
        0x16:
            id: course_22
        0x17:
            id: course_01_after_boss
        0x18:
            id: course_19
        0x19:
            id: course_05
        0x1a:
            id: course_36
        0x1b:
            id: course_24
        0x1c:
            id: course_25
        0x1d:
            id: course_32
        0x1e:
            id: course_27
        0x1f:
            id: course_28
        0x20:
            id: course_18
        0x21:
            id: course_14
        0x22:
            id: course_38
        0x23:
            id: course_39
        0x24:
            id: course_03_after_boss
        0x25:
            id: course_37
        0x27:
            id: course_23
        0x28:
            id: course_40
        0x29:
            id: course_06
        0x2a:
            id: course_31

    powerups:
        0x0:
            id: small_wario
        0x1:
            id: wario
        0x2:
            id: bull_wario
        0x3:
            id: jet_wario
        0x4:
            id: dragon_wario

    progression:
        0x0:
            id: incomplete
        0x1:
            id: complete
