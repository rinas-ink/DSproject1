@echo off
setlocal enabledelayedexpansion

set "command_to_run=java -cp bin contention.benchmark.Test -W 0 -d 2000"

set "b_values=linkedlists.lockbased.CoarseGrainedListBasedSet linkedlists.lockbased.HandOverHandListBasedSet linkedlists.lockbased.LazyLinkedListSortedSet "
set "t_values=1 4 6 8 10 12 14 16 18 20"
set "u_values=0 10 30 50 80 100"
set "i_values=100 1000 10000"

type nul > output3big.txt

for %%b in (%b_values%) do (
  for %%t in (%t_values%) do (
    for %%u in (%u_values%) do (
      for %%i in (%i_values%) do (
        set /a "r=%%i * 2"
        set "arguments=-b %%b -t %%t -u %%u -i %%i -r !r!"
        set "output=!arguments!"

        for /f "tokens=3" %%a in ('%command_to_run% !arguments! ^| findstr /C:"Throughput (ops/s):"') do (
          set "output=%%a"
        )

        echo !output!>>output3big.txt
      )
    )
  )
)

echo Done!
