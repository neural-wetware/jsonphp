# jsonphp

Reads JSON from stdin and outputs valid code for PHP array.

    $ echo "[{}, {\"x\": 123, \"name\": \"John\", \"age\": 20}, {\"age\": 30, \"name\": \"Frank\"} ]" | ./jsonphp 
    [
        [
        ],
        [
            'age' => 20,
            'name' => 'John',
            'id' => 123,
        ],
        [
            'age' => 30,
            'name' => 'Frank',
        ],
    ]
