{
  services.thinkfan = {
    enable = true;
    levels = [
      [0  0   30] # Fan off until 30C
      [1  25  40] # Level 1 fan at 25C, full at 40C (quietest active speed)
      [2  35  50] # Level 2 fan at 35C, full at 50C
      [3  45  60] # Level 3 fan at 45C, full at 60C
      [4  55  70] # Level 4 fan at 55C, full at 70C
      [5  65  75] # Level 5 fan at 65C, full at 75C
      [7  70  80] # Level 7 fan (max) at 70C, full at 80C
      ["level auto" 75 32767] # Max fan speed at 75C and above, or let BIOS handle
    ];
  };
}