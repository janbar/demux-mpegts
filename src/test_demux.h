/*
 *      Copyright (C) 2013 Jean-Luc Barriere
 *
 *  This Program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This Program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to
 *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 *  http://www.gnu.org/copyleft/gpl.html
 *
 */

#ifndef TEST_DEMUX_H
#define TEST_DEMUX_H

#include <fcntl.h>

#include "tsDemuxer.h"


#define AV_BUFFER_SIZE          131072
#define POSMAP_PTS_INTERVAL     270000LL

using namespace std;

class Demux : public TSDemuxer
{
public:
  Demux(FILE* file, uint16_t channel);
  ~Demux();

  int Do(void);

  const unsigned char* ReadAV(uint64_t pos, size_t n);

private:
  FILE* m_ifile;
  uint16_t m_channel;
  std::map<uint16_t, FILE*> m_outfiles;

  bool get_stream_data(ElementaryStream::STREAM_PKT* pkt);
  void reset_posmap();
  void register_pmt();
  void show_stream_info(uint16_t pid);
  void write_stream_data(ElementaryStream::STREAM_PKT* pkt);

  // AV raw buffer
  size_t m_av_buf_size;         ///< size of av buffer
  uint64_t m_av_pos;            ///< absolute position in av
  unsigned char* m_av_buf;      ///< buffer
  unsigned char* m_av_rbs;      ///< raw data start in buffer
  unsigned char* m_av_rbe;      ///< raw data end in buffer

  // Playback context
  AVContext* m_AVContext;
  uint16_t m_mainStreamPID;     ///< PID of main stream
  uint64_t m_DTS;               ///< absolute decode time of main stream
  uint64_t m_PTS;               ///< absolute presentation time of main stream
  int64_t m_pinTime;            ///< pinned relative position (90Khz)
  int64_t m_curTime;            ///< current relative position (90Khz)
  int64_t m_endTime;            ///< last relative marked position (90Khz))
  typedef struct
  {
    uint64_t av_pts;
    uint64_t av_pos;
  } AV_POSMAP_ITEM;
  std::map<int64_t, AV_POSMAP_ITEM> m_posmap;
};

#endif /* TEST_DEMUX_H */

