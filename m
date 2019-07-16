Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06326AB61
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Jul 2019 17:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbfGPPHb (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 11:07:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:22636 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGPPHb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 11:07:31 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 11:07:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563289649;
        s=strato-dkim-0002; d=fpond.eu;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=9MyPAKL8aOMdkgUeGxkG2hiV9y7ijQeVQyamlGPGLLY=;
        b=m145j/VfyRajzX6zEg9WoTavT4TpZOlAGGZhP0x+I3+5GjQmZ1Rbv5xJ6PpLhIi9W3
        OV/7VH0MBtNdzLqUie5+EkK30Pmtn31kvvCsMwoo4nQo7MCseE9nMYU2miYML2jqcdJ5
        JWJjnJ1s2XKBbWJ1YdVPzxzNyHEvzBCg6O3265rwpiOU86LelvppDAMBfFDjEzmZGxKf
        q3ifvSHPjVfwQMXbS0Uc4JDUI8lanhgmBG31sECi2spHsJZ2Lgzml6CzCShL0vrPfzZh
        qJvLOxOpqq6OzJIfRCeJjP+e9edY6d4viaWtSbot5Uxe7vPvyFvrTbzhi8tckeV983Wb
        BmTg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73dmm4I5W0/AvA67Ot4fvR82dYd7rJSdw="
X-RZG-CLASS-ID: mo00
Received: from groucho.site
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id h0a328v6GF1Cd5G
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 16 Jul 2019 17:01:12 +0200 (CEST)
From:   Ulrich Hecht <uli+renesas@fpond.eu>
To:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     niklas.soderlund@ragnatech.se, wsa@the-dreams.de,
        yamada.masahiro@socionext.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, magnus.damm@gmail.com,
        Ulrich Hecht <uli+renesas@fpond.eu>
Subject: [PATCH 0/2] mmc: tmio: remove Gen2+ workaround and fix up
Date:   Tue, 16 Jul 2019 17:01:02 +0200
Message-Id: <1563289264-26432-1-git-send-email-uli+renesas@fpond.eu>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi!

The second patch in this series removes a workaround that forced eMMC devices
always on and that is no longer required.

Removing it does expose a bug, however, that leads to a clock imbalance due
to the clock being enabled by both PM and the hardware driver. (See
https://www.spinics.net/lists/linux-mmc/msg54009.html for discussion.)
This bug is taken care of by the first patch.

Tested on r8a7790 (Lager), r8a7795 and r8a7796 (Salvator-X) with SD and
eMMC, before and after suspend.

CU
Uli


Ulrich Hecht (2):
  mmc: tmio: leave clock handling to PM if enabled
  mmc: tmio: remove obsolete PM workaround

 drivers/mmc/host/tmio_mmc_core.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

-- 
2.7.4

