/*
 *  Copyright (C) 2013-2021 Jean-Luc Barrière
 *  Copyright (C) 2005-2014 Team Kodi (https://kodi.tv)
 *
 *  SPDX-License-Identifier: GPL-2.0-or-later
 *  See LICENSE.md for more information.
 */

#ifndef ES_AC3_H
#define ES_AC3_H

#include "elementaryStream.h"

namespace TSDemux
{
  class ES_AC3 : public ElementaryStream
  {
  private:
    int         m_SampleRate;
    int         m_Channels;
    int         m_BitRate;
    int         m_FrameSize;

    int64_t     m_PTS;                /* pts of the current frame */
    int64_t     m_DTS;                /* dts of the current frame */

    int FindHeaders(uint8_t *buf, int buf_size);

  public:
    ES_AC3(uint16_t pid);
    virtual ~ES_AC3();

    virtual void Parse(STREAM_PKT* pkt);
    virtual void Reset();
  };
}

#endif /* ES_AC3_H */
