/*
 *  Copyright (C) 2013-2021 Jean-Luc Barrière
 *  Copyright (C) 2005-2014 Team Kodi (https://kodi.tv)
 *
 *  SPDX-License-Identifier: GPL-2.0-or-later
 *  See LICENSE.md for more information.
 */

#ifndef ES_MPEGAUDIO_H
#define ES_MPEGAUDIO_H

#include "elementaryStream.h"

namespace TSDemux
{
  class ES_MPEG2Audio : public ElementaryStream
  {
  private:
    int         m_SampleRate;
    int         m_Channels;
    int         m_BitRate;
    int         m_FrameSize;

    int64_t     m_PTS;
    int64_t     m_DTS;

    int FindHeaders(uint8_t *buf, int buf_size);

  public:
    ES_MPEG2Audio(uint16_t pid);
    virtual ~ES_MPEG2Audio();

    virtual void Parse(STREAM_PKT* pkt);
  };
}

#endif /* ES_MPEGAUDIO_H */
