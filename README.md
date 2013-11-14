demux-mpegts
============

Building: make

Testing: Go to folder build then run test_demux

Usage:

  test_demux [options] [ts filename]
  
Options:

  --debug         Enable debug level
  --parseonly     Parse only ts file without output streams
  --channel [no]  Parse stream only for specified channel no

Output stream file are formated like:

  stream_[channel]_[PID]_[type extension]
