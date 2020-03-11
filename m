Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A225181213
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Mar 2020 08:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgCKHk5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-mmc@lfdr.de>); Wed, 11 Mar 2020 03:40:57 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33175 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKHk5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 03:40:57 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 60A9F1BF205;
        Wed, 11 Mar 2020 07:40:53 +0000 (UTC)
Date:   Wed, 11 Mar 2020 08:40:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH -next 013/491] INGENIC JZ47xx SoCs: Use fallthrough;
Message-ID: <20200311084052.3ca3c331@xps13>
In-Reply-To: <ad408ff8dc4e5fae0884312cb0aa618664e546e5.1583896348.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
        <ad408ff8dc4e5fae0884312cb0aa618664e546e5.1583896348.git.joe@perches.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Joe,

Joe Perches <joe@perches.com> wrote on Tue, 10 Mar 2020 21:51:27 -0700:

> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c           | 2 +-
>  drivers/mmc/host/jz4740_mmc.c                   | 6 ++----
>  drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 2 +-
>  drivers/mtd/nand/raw/ingenic/jz4725b_bch.c      | 4 ++--
>  drivers/mtd/nand/raw/ingenic/jz4780_bch.c       | 4 ++--
>  sound/soc/codecs/jz4770.c                       | 2 +-
>  6 files changed, 9 insertions(+), 11 deletions(-)

I like very much the new way to advertise for fallthrough statements,
but I am not willing to take any patch converting a single driver
anymore. I had too many from Gustavo when these comments had to be
inserted. I would really prefer a MTD-wide or a NAND-wide or at least a
raw-NAND-wide single patch (anything inside drivers/mtd/nand/raw/).

Hope you'll understand!

Thanks,
Miquèl
