BEGIN {
  print "High Scores:\n"
}

{
    print $1 " has completed the game in " $2 " seconds"
}

END {
  if ( NR == 0)
    print "No High Scores"
}
