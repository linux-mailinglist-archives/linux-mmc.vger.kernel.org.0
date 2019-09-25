Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD2BE5FD
	for <lists+linux-mmc@lfdr.de>; Wed, 25 Sep 2019 22:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfIYUB3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 25 Sep 2019 16:01:29 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:44417 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfIYUB2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Sep 2019 16:01:28 -0400
Received: by mail-lj1-f179.google.com with SMTP id m13so6969390ljj.11
        for <linux-mmc@vger.kernel.org>; Wed, 25 Sep 2019 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=s5wwxTyTDa55aQZtv0+ZgEX7xgGF5fBsXI69BKYf71A=;
        b=aixefv/ISzcW+I2UhnTkIIiLgiqqD0I/W2+S+W3lUWD7RUd1ycjbbkpDT9ctzghJF4
         DQxSJqAYa067E8rGQQwqyIA8pMI0s36/VLmIWVuWxyX1kmvWRpSywINqdQWKAW047G3h
         z4CGv00I84j/pWZKKfUWhLRWPWW3GgUsvsoebT15eKeYS19hVuOTBg8CvtHwVeNxZQlt
         1/2cMJbOn+JNBR3qx7GotMD445Y0ScEuoRto7G9RyPf0noxjBBjNVO+KUVyUAlMY8bYl
         YUygpBV5Pya019SPEb4O4ue9rH8p0JgCflK0afZAqGxL2cT33d5V53RC8A0cwXokHtxZ
         2uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=s5wwxTyTDa55aQZtv0+ZgEX7xgGF5fBsXI69BKYf71A=;
        b=XcAs/gz95ALeQ0xbPlXY5ZChn7h+AVizZw5+h4uAgCjQsQSi/hzPJS6XQ8jQqevL0g
         UROLGmfMLWcyyKXuLDtHOhXjfni7+Pob+FE5BtdMs8Y2a2omZ7RIMwL2JHkAC4/hBUZx
         yBo6BwAqd9ytb6iBPDbcE7ets7FYQMyOkwOLoWoubaTQFS0QMD4CQSWLmVlSCj7JwALT
         EHBo8IF19p2BWu/rzJp1kLqBHM0gUtUxXNaQBWbtaqiHvyEYYzEcjO6tMM88nY4iUL48
         gTAXcQOsrRuQ6vGTWBeEYVvak9I1LPT3fbqUMG6nKtKlEU8/xBAKWYymCeoax16seTqa
         0kSg==
X-Gm-Message-State: APjAAAW7JHSQPZupfLLpgEYIy75oGnixjrkm9pmWF5RRpOI19lMjMB+O
        ZNivxUJa76VXQW6rHsytWeCaht2kjbjjsVDcOdU=
X-Google-Smtp-Source: APXvYqwS99/VjRgPmHWy2p+b7GcjTBJZg+mCjahw0cYQpxp9J8YO92EGhzfl40nnN7Gy+6mzth44JfMvGacRa+Nb4Yc=
X-Received: by 2002:a2e:9450:: with SMTP id o16mr64458ljh.178.1569441686543;
 Wed, 25 Sep 2019 13:01:26 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 25 Sep 2019 17:01:35 -0300
Message-ID: <CAOMZO5DmkV10xrz7g_JzU-LokoxcCair_2xP4S-ZBCtmnprhZA@mail.gmail.com>
Subject: SD card failure on i.MX7ULP EVK
To:     Yongcai Huang <anson.huang@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

When booting a 5.2 or 5.3 kernel on imx7ulp-evk I see the following sdhc error:

[    3.132133] sdhci-esdhc-imx 40370000.mmc: Got CD GPIO
[    3.238632] mmc0: Reset 0x1 never completed.
[    3.242935] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    3.249490] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
[    3.256047] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
[    3.262515] mmc0: sdhci: Argument:  0x0000885c | Trn mode: 0x00000000
[    3.269071] mmc0: sdhci: Present:   0x00088088 | Host ctl: 0x00000002
[    3.275620] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000080
[    3.282084] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000007f
[    3.288640] mmc0: sdhci: Timeout:   0x0000008c | Int stat: 0x00000000
[    3.295190] mmc0: sdhci: Int enab:  0x007f010b | Sig enab: 0x00000000
[    3.301653] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00008402
[    3.308209] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b400
[    3.314671] mmc0: sdhci: Cmd:       0x0000113a | Max curr: 0x00ffffff
[    3.321225] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x003b377f
[    3.327775] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
[    3.334239] mmc0: sdhci: Host ctl2: 0x00000000
[    3.338788] mmc0: sdhci: ============================================
[    3.447581] mmc0: Reset 0x1 never completed.
[    3.451890] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    3.458453] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
[    3.465008] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
[    3.471469] mmc0: sdhci: Argument:  0x0000885c | Trn mode: 0x00000000
[    3.478027] mmc0: sdhci: Present:   0x00088088 | Host ctl: 0x00000002
[    3.484493] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000080
[    3.491051] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000007f
[    3.497601] mmc0: sdhci: Timeout:   0x0000008c | Int stat: 0x00000000
[    3.504063] mmc0: sdhci: Int enab:  0x00000000 | Sig enab: 0x00000000
[    3.510618] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00008402
[    3.517171] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b400
[    3.523633] mmc0: sdhci: Cmd:       0x0000113a | Max curr: 0x00ffffff
[    3.530189] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x003b377f
[    3.536740] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
[    3.543201] mmc0: sdhci: Host ctl2: 0x00000000
[    3.547756] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
[    3.554214] mmc0: sdhci: ============================================
[    3.601580] mmc0: SDHCI controller on 40370000.mmc [40370000.mmc] using ADMA

Any ideas?

Thanks,

Fabio Estevam
