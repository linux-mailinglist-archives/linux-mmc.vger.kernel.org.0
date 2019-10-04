Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB6CBB8D
	for <lists+linux-mmc@lfdr.de>; Fri,  4 Oct 2019 15:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfJDNV3 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 4 Oct 2019 09:21:29 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:41090 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388426AbfJDNV3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Oct 2019 09:21:29 -0400
Received: by mail-lf1-f49.google.com with SMTP id r2so4461702lfn.8
        for <linux-mmc@vger.kernel.org>; Fri, 04 Oct 2019 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mNRPra/D40YWtO9URfz48o4hFrgAmXknj1Avr7eG9mc=;
        b=PJ5Oo6qQ7jf8KiGO8canx7ZSv3LkZVcDjyyZHQATgMrBGiMOxq80wwsgUc49IBrwvN
         CVUgF+eB79I3kSvEaCS+HShG9fHspO1e/i9T7Iyrfw+1L2715s9yaWgk/cw2ewxh/9r2
         wQRtibBVd2MzPcPfjiP5bFRw0IX8EWYfMvFH661alpq/nVDfeSvO0YAw8qWrrSumEVRJ
         bzy2rfM8tZ3EL0QnSWhLP0JZfnsUilOz0IGumybRW1VtmG9XHHELKSofKnXy6mR2kDmm
         xl8X5+wvX29p1SzHSPcy+SeUwH456OEe2YVBcd/8cD0EcIYFhYMCLakR09BZ5QCTOh9x
         /ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mNRPra/D40YWtO9URfz48o4hFrgAmXknj1Avr7eG9mc=;
        b=hne7O4x9nDZGKcRTluITLJCT1KI/wtBKlqTE2p1zROQRLf3785kE6fMvOoaKpQWIC3
         xHqd9xV+myOZHRdVpKOcnFpO1bqe8nUiC3hh990jVwY9EeD2wAd6aPYU34be0CIUMbwy
         WLeVhNrKzJzEDz+xLTBwuOYMofWdBo+6JXnt7MUpFxLTGqPkzm9FWqhtH9fixRQySxgd
         RvBFM92ydjQTxAjW4a5/K3bAxgfRDpF4mMaX6qxTf2HbGAgzBnlgUHPNeud8tSXKDySB
         91QcEP/vVGixZzL3UHI/fymfw2H1jMPmFC6XuKDWcYGggIDKL4u3ck3ZiCwHOpzdS6f4
         P2fg==
X-Gm-Message-State: APjAAAUJpoZcd3qkOSx+D314/NVFJoNwvYZix6nFnmRscSyZrixJBmSU
        My2adXB2SIO0QpT1Rd8Bl2fUdCNwPSRLkXD8TuBb/cgA9ls=
X-Google-Smtp-Source: APXvYqycha/dHaXScVMTAD0s9BLYIXWmbMJ4m7CvW4og9+OW/yVy8jKXlm0i4PkL78MjvYdF5ZWqvdKbgF0Q1jb/INY=
X-Received: by 2002:a19:6008:: with SMTP id u8mr8972057lfb.12.1570195287508;
 Fri, 04 Oct 2019 06:21:27 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 4 Oct 2019 10:21:46 -0300
Message-ID: <CAOMZO5ACYH_vuf4FevsPNkdxt8Y0irFeDNDcFns1bhsxB=M68w@mail.gmail.com>
Subject: mmc failure on mx28 running 5.3.2
To:     Marek Vasut <marex@denx.de>, Stefan Wahren <info@lategoodbye.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Booting kernel 5.3.2 on a imx28-evk leads to the mmc following error:

[    4.781251] Waiting for root device /dev/mmcblk0p3...
[    6.786434] mmc0: error -110 whilst initialising SDIO card
[    6.792765] mxs-mmc 80010000.spi: no support for card's volts
[    6.798635] mmc0: error -22 whilst initialising SD card
[   10.463583] mmc0: error -110 whilst initialising SDIO card
[   10.469429] mxs-mmc 80010000.spi: no support for card's volts
[   10.475520] mmc0: error -22 whilst initialising SD card
[   12.861119] mxs-mmc 80010000.spi: card claims to support voltages
below defined range
[   12.869069] mxs-mmc 80010000.spi: no support for card's volts
[   12.875141] mmc0: error -22 whilst initialising SDIO card
[   12.881346] mxs-mmc 80010000.spi: no support for card's volts
[   12.887213] mmc0: error -22 whilst initialising SD card
[   16.543620] mmc0: error -110 whilst initialising SDIO card
[   16.549490] mxs-mmc 80010000.spi: no support for card's volts
[   16.555588] mmc0: error -22 whilst initialising SD card
[   18.941140] mxs-mmc 80010000.spi: card claims to support voltages
below defined range
[   18.949093] mxs-mmc 80010000.spi: no support for card's volts
[   18.955165] mmc0: error -22 whilst initialising SDIO card
[   18.961103] mxs-mmc 80010000.spi: no support for card's volts

I haven't debugged this regression yet, but I am wondering if anyone
else has an idea about it.

Thanks,

Fabio Estevam
