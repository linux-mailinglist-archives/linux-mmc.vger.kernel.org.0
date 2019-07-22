Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C847270CAD
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 00:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfGVWb3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 18:31:29 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:39134 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbfGVWb1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 18:31:27 -0400
Received: by mail-vs1-f49.google.com with SMTP id u3so27477406vsh.6;
        Mon, 22 Jul 2019 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/o2k/7A4mi6mmVCfxJlOxqWAUX0Qz3CzagiJIcOlAnA=;
        b=ocTGL9HqsouxSGJDhNyDgQr13NNckuh6VIqnEUF4wHJ+A0RcZpbG/y839YAhORxGx4
         F0BPU+F98oJ/2PP+1iJKcxSclPf86oU7PrFUjzKb8z9rQPh41vckJFe35KS5XskRGj0x
         FL85SBMfI7Q4+DpFA6vFzY3EPopMIp0mhI0VYsq0QJhb2HlNzm6gBfsgUhygwnBIE/Ra
         CcFqsOGEqxX5+FEwCoqdZwX5PcmL9BgRKF2gmUHWenOHzNv6Nk/dJwxl8+oXku1s/kgF
         KOikEn7y4LaVcIQXikNs9EamnVX3IiuOeTCxgZm4KEDiXNUli0L2YaPjz9Ovm6J3//hi
         eeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/o2k/7A4mi6mmVCfxJlOxqWAUX0Qz3CzagiJIcOlAnA=;
        b=CrCZBIN34noOnVvucAXlXFf+o4p2Vzp3PpWe9zyTODJD3umHxnpX/n+bc2RU5Z+KE0
         OHno31xL3cyE4D+te9nrt46FSfoCR8vsU/l0sXmn0RkwjcQvj3l/xQY8yAmBzSI4Teod
         G0enfnSUkq+xyy/VD8UMgC2h1bm5C00Wc3wzH1KozLdtZM59qe2QUJPbg82WtPShYF89
         Bvtb/XexdOWBFqQilLOkdNykAR5+DjFr/aB55NLhfO5iiIyKXkgD+og/YI3BdcRmtet9
         GScJt6Zje+rLlIgrGdEf/VFNN50TcnVMBJpwYW0rkmzzVj5/Tq/b3l7gr5op0SQMWK3T
         Nsgg==
X-Gm-Message-State: APjAAAUE7vDqQHuGRDITgrrkGbgyMWBQ192j0S8YN1n0wclCS3ZCKKWQ
        pjCd/K/Z80/eyykXzu0Oi+O7peerrmfv1eyNsqg=
X-Google-Smtp-Source: APXvYqxXptS2Hn9wtEsd9cf2MyXFHeX42usyQVwQ8ag2dnjeEQYrWkVQK3Ow5MBemIeDQz5A79cfTmLKrqvvSuC2xsg=
X-Received: by 2002:a67:edcf:: with SMTP id e15mr45234565vsp.75.1563834687000;
 Mon, 22 Jul 2019 15:31:27 -0700 (PDT)
MIME-Version: 1.0
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Mon, 22 Jul 2019 18:31:59 -0400
Message-ID: <CAOGqxeVeEq803rrtGrnubRA8cP3dRCXsU15ss3pS1q6ik+k8Bw@mail.gmail.com>
Subject: Issue with sequence to switch to HS400
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "cc: Adrian Hunter" <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I'm having a problem with a new SD/MMC controller and PHY in our
latest SoC's. The issue I'm seeing is that I can't switch into HS400
mode. This looks like something the driver is doing that doesn't meet
the JEDEC spec. In the "HS400 timing mode selection" section of the
JEDEC spec , in step 7 it states:

7) Set the =E2=80=9CTiming Interface=E2=80=9D parameter in the HS_TIMING [1=
85] field
of the Extended CSD register to 0x1 to switch to High Speed mode and
then set the clock frequency to a value not greater than 52 MHz.

In the function mmc_select_hs400() in mmc.c, I see that a switch
command is done to set the eMMC device to HS mode and then
mmc_set_timing(card->host, MMC_TIMING_MMC_HS) is used to change the
controller to HS mode. The problem is that the "SD Host Controller
Standard Specification" states that "UHS Mode Select" field of the
"Host Control 2 Register" controls the mode when the "1.8V Signaling
Enable" bit in the same register is set, so mmc_set_timing() is
actually leaving the controller in SDR12 mode and mmc_select_hs400()
will then set the clock to 52MHz. This causes our PHY to detect an
illegal combination and return an error.

I think the easiest fix would be to change mmc_set_timing(card->host,
MMC_TIMING_MMC_HS) to mmc_set_timing(card->host,
MMC_TIMING_UHS_SDR25). The other possibility would be to change
mmc_set_timing to handle the "1.8V Signaling Enable" bit properly.
I'll submit a patch based on the feedback I get.

Thanks
Al Cooper
