/*
 *  Copyright (C) 2013-2021 Jean-Luc Barrière
 *  Copyright (C) 2005-2014 Team Kodi (https://kodi.tv)
 *
 *  SPDX-License-Identifier: GPL-2.0-or-later
 *  See LICENSE.md for more information.
 */

#ifndef ES_AAC_H
#define ES_AAC_H

#include "elementaryStream.h"
#include "bitstream.h"

namespace TSDemux
{
  class ES_AAC : public ElementaryStream
  {
  private:
    int         m_SampleRate;
    int         m_Channels;
    int         m_BitRate;
    int         m_FrameSize;

    int64_t     m_PTS;                /* pts of the current frame */
    int64_t     m_DTS;                /* dts of the current frame */

    bool        m_Configured;
    int         m_AudioMuxVersion_A;
    int         m_FrameLengthType;

    int FindHeaders(uint8_t *buf, int buf_size);
    bool ParseLATMAudioMuxElement(CBitstream *bs);
    void ReadStreamMuxConfig(CBitstream *bs);
    void ReadAudioSpecificConfig(CBitstream *bs);
    uint32_t LATMGetValue(CBitstream *bs) { return bs->readBits(bs->readBits(2) * 8); }

  public:
    ES_AAC(uint16_t pes_pid);
    virtual ~ES_AAC();

    virtual void Parse(STREAM_PKT* pkt);
    virtual void Reset();
  };
}

#endif /* ES_AAC_H */
