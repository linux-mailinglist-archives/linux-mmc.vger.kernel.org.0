Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2CE69E45C
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 11:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfH0Jd4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 05:33:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33051 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfH0Jd4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 05:33:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so20667576qtb.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OjaVvUwc/WRK2bsf7srFakOYUwgWdxEpUwIvpwT8HL8=;
        b=Bix+HxJydzntbwU7tidsymOZkveU2hxrrbxW5DTRGAsi3JSrSoxGm2+Axt9QXsf/C1
         XGZ7e0Q1qwn+xAeWnSad+39ZbRFYg6cWiFl1YH6VNSSCOjfwwgt/RHRoALvZ/gUZt/D7
         e/4JSVJEXAhzAQS21fs5GWlxCtsfegSYd2/YlJL7qMbA4N3mSABUbyEsJI7XxorO6EIB
         0RCGC6idzLKc4S797fOLb0Pvba7liGNIHu/kQrz+tvrZlF8YTXwpsUFrrY7LzoQD5ZU3
         dduZbB6Ha2cYwuJPuH8ttd2Xuyy5r2vAqkGYheaIR4cfV7dxJtUamuLaxKnUbzwwKJek
         IYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OjaVvUwc/WRK2bsf7srFakOYUwgWdxEpUwIvpwT8HL8=;
        b=FfuQV4A/rZ1N+rqMLgOFcas96isC3pcP9RbhN5MxF4xQiI42t0VZP4PRqRHkHrQtAD
         8EWNzzglzrDIrzqyh2ZWKL4fGRH1L4Tw1hqrOaG9Woap3+zi+t1mRJliTPEZgpOInh9+
         zQdvfSkiRXSmvTkoGIzZGCA1oBL5R5PTDVuTHmo/vf6AJaWp5BgQbq2gtHMrpF6vTz8l
         77dTdGij4fV2KXJDMpL3CpZkiDbqtswgjWvHylySlU/mM3EOkzFAxw1Edcg13jP8v58s
         BKElHqk4RASnXvNRa8R9KmJYYi5Tvgx109H5jHC/a583G97ZHOcQjXcGAMdHtSMSKMHf
         eV3Q==
X-Gm-Message-State: APjAAAVvoaXCpJX82Jdu5iDvbf6/vvFaSPevujfR64a1ZY4f5fUg3WOw
        a24VsaeF4Lh7sKtrkNoIdZLjMRh7dpo0u2dDCveqMA==
X-Google-Smtp-Source: APXvYqyKlIOAcAHiZtC6OQSo6kzRB+6nOAhXyrFxckaOlHsrNIbqzs2lbDFyabRnD4z507xPwu/mRKfl9/vblJpNQ2Q=
X-Received: by 2002:ac8:322e:: with SMTP id x43mr20244184qta.213.1566898435406;
 Tue, 27 Aug 2019 02:33:55 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 27 Aug 2019 17:33:44 +0800
Message-ID: <CAD8Lp45KCxfND9gKwmmrB5KqUF7dattwMGMX94+OpspGFJS12A@mail.gmail.com>
Subject: sdhci-pci-o2micro no longer detects eMMC device
To:     ernest.zhang@bayhubtech.com
Cc:     linux-mmc@vger.kernel.org,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

As of recent kernels, the eMMC storage is no longer detected on this
MiniPC which has eMMC connected to:

02:00.0 SD Host controller [0805]: O2 Micro, Inc. Device [1217:8620]
(rev 01) (prog-if 01)
    Subsystem: O2 Micro, Inc. Device [1217:0002]

git bisect found the commit that introduces the problem:

commit 414126f9e5abf1973c661d24229543a9458fa8ce (HEAD, refs/bisect/bad)
Author: Ernest Zhang(WH) <ernest.zhang@bayhubtech.com>
Date:   Fri Jan 18 06:04:53 2019 +0000

    mmc: sdhci: Remove unneeded quirk2 flag of O2 SD host controller

With this commit applied, these are the logs from loading the driver,
showing the failure to detect the storage device:

sdhci-pci 0000:00:14.7: SDHCI controller found [1022:7813] (rev 1)
mmc0: SDHCI controller on PCI [0000:00:14.7] using ADMA
sdhci-pci 0000:02:00.0: SDHCI controller found [1217:8620] (rev 1)
pcieport 0000:00:02.4: can't derive routing for PCI INT A
sdhci-pci 0000:02:00.0: PCI INT A: not connected
mmc1: SDHCI controller on PCI [0000:02:00.0] using ADMA
mmc1: Got data interrupt 0x02000000 even though no data operation was
in progress.
mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
mmc1: sdhci: Argument:  0x03af0101 | Trn mode: 0x00000013
mmc1: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000011
mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
mmc1: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
mmc1: sdhci: Cmd:       0x0000061b | Max curr: 0x005800c8
mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
mmc1: sdhci: Resp[2]:   0x329f5903 | Resp[3]:  0x00d0ffff
mmc1: sdhci: Host ctl2: 0x00000000
mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x3d005208
mmc1: sdhci: ============================================
mmc1: Timeout waiting for hardware interrupt.
mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
mmc1: sdhci: Argument:  0x03af0101 | Trn mode: 0x00000013
mmc1: sdhci: Present:   0x01ff0006 | Host ctl: 0x00000011
mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
mmc1: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
mmc1: sdhci: Cmd:       0x0000061b | Max curr: 0x005800c8
mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
mmc1: sdhci: Resp[2]:   0x329f5903 | Resp[3]:  0x00d0ffff
mmc1: sdhci: Host ctl2: 0x00000000
mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x3d005208
mmc1: sdhci: ============================================
mmc1: error -110 whilst initialising MMC card
mmc1: Got data interrupt 0x02000000 even though no data operation was
in progress.
mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
mmc1: sdhci: Argument:  0x03af0101 | Trn mode: 0x00000013
mmc1: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000011
mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00004e47
mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
mmc1: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
mmc1: sdhci: Cmd:       0x0000061b | Max curr: 0x005800c8
mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
mmc1: sdhci: Resp[2]:   0x329f5903 | Resp[3]:  0x00d0ffff
mmc1: sdhci: Host ctl2: 0x00000000
mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x3d005208
mmc1: sdhci: ============================================


Please let me know if I can provide further info to help understand
this problem.

Thanks
Daniel
