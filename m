Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E685CD78E0
	for <lists+linux-mmc@lfdr.de>; Tue, 15 Oct 2019 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbfJOOk6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 15 Oct 2019 10:40:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50563 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732448AbfJOOk5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2019 10:40:57 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iKO0N-0003SG-8e; Tue, 15 Oct 2019 16:40:55 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iKO0M-0002Mf-D3; Tue, 15 Oct 2019 16:40:54 +0200
Date:   Tue, 15 Oct 2019 16:40:54 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marek Vasut <marex@denx.de>, Stefan Wahren <info@lategoodbye.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: mmc failure on mx28 running 5.3.2
Message-ID: <20191015144054.kd2cgn2xhctr6x3w@pengutronix.de>
References: <CAOMZO5ACYH_vuf4FevsPNkdxt8Y0irFeDNDcFns1bhsxB=M68w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5ACYH_vuf4FevsPNkdxt8Y0irFeDNDcFns1bhsxB=M68w@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:38:49 up 99 days, 20:49, 105 users,  load average: 0.04, 0.12,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Fabio,

On Fri, Oct 04, 2019 at 10:21:46AM -0300, Fabio Estevam wrote:
> Hi,
> 
> Booting kernel 5.3.2 on a imx28-evk leads to the mmc following error:
> 
> [    4.781251] Waiting for root device /dev/mmcblk0p3...
> [    6.786434] mmc0: error -110 whilst initialising SDIO card
> [    6.792765] mxs-mmc 80010000.spi: no support for card's volts
> [    6.798635] mmc0: error -22 whilst initialising SD card
> [   10.463583] mmc0: error -110 whilst initialising SDIO card
> [   10.469429] mxs-mmc 80010000.spi: no support for card's volts
> [   10.475520] mmc0: error -22 whilst initialising SD card
> [   12.861119] mxs-mmc 80010000.spi: card claims to support voltages
> below defined range
> [   12.869069] mxs-mmc 80010000.spi: no support for card's volts
> [   12.875141] mmc0: error -22 whilst initialising SDIO card
> [   12.881346] mxs-mmc 80010000.spi: no support for card's volts
> [   12.887213] mmc0: error -22 whilst initialising SD card
> [   16.543620] mmc0: error -110 whilst initialising SDIO card
> [   16.549490] mxs-mmc 80010000.spi: no support for card's volts
> [   16.555588] mmc0: error -22 whilst initialising SD card
> [   18.941140] mxs-mmc 80010000.spi: card claims to support voltages
> below defined range
> [   18.949093] mxs-mmc 80010000.spi: no support for card's volts
> [   18.955165] mmc0: error -22 whilst initialising SDIO card
> [   18.961103] mxs-mmc 80010000.spi: no support for card's volts
> 
> I haven't debugged this regression yet, but I am wondering if anyone
> else has an idea about it.

Have you seen https://www.spinics.net/lists/linux-mtd/msg09535.html? I
think your issue is something else though.

Regards
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
