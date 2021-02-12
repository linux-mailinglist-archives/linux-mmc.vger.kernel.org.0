Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1A319E4E
	for <lists+linux-mmc@lfdr.de>; Fri, 12 Feb 2021 13:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhBLMXm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 12 Feb 2021 07:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhBLMVi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2021 07:21:38 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA5C061793
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 04:20:57 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id w140so2023472vkw.0
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 04:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RhO0gNQrZVLMzkl1AUbIsI4T6+7IJPcDywrN4y5sl2A=;
        b=ymdcIHciR9I4+GKVbE+TWcLxxk/mjizaRFTD3FVF2MNu5+UaKKpE9dnLW2eMjmxnZN
         4KNIST8ba0f64YFrv+fOIEazCG4q5JjpIwnsmxUQqUaTfBPyqPP2ufcwnlinKr2HQkri
         IwdoVZeOmKzlZ847IDCjJTdGcSDvvMU8UWZ8fNkkPHfSC5xoQPv4vAAJLVZS8UDhvHsV
         +/4yYugmOI0fYbVtz4zTmSNg8Mt4iJVcWiZQQfsOcYl4ucFkgeBdijQIlmcOOHYDjhLq
         tGWT3tWccnAd0MxJDy4VI0Br3iqQas0D5DTBwakxIbMJ+hSzesqpx3SdItj9Kv+/nBtS
         5ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RhO0gNQrZVLMzkl1AUbIsI4T6+7IJPcDywrN4y5sl2A=;
        b=oZd7EWGW10pctZg+Wl7cL34TlbAaaWZZQ4ThzEL146+lM/taH7TyV1SRjyf9LplkJ3
         ZcCcTX7/mmG7IzI3o4BmcDl38vTB8q0AqzmQg38BJC0T8EfNgTC0Wl9yKkKbrVU5myoD
         68/IuKd3qpDDrf2AH5v6vtUaVMKu++xN7kObujl6sjvIUJDQmBpFMoX9VOAtwmLwtzsd
         dAiImOEg37Av2MqxlEy0FNPge6LYoM2IqbbV0ZX8AxYMqTSoZ5W3nuBKbxm47clWCUb8
         r1a0ZZSXTAH3DOqrVOgPrvAFLl8enVzLr7yeMchxW/EIsIECArn+5E4Nllrnxevs70+U
         KuOg==
X-Gm-Message-State: AOAM530nFBEUP8fz7kX3eEUQiHTuTMk1158Q23uOWnEQ9Ob24P1zhMvi
        zCocIQTfWvJ9X82R4kVUrrtFmMHfANEmPPe60geGcg==
X-Google-Smtp-Source: ABdhPJyhlfUY18TwviKpqnsOEe1UakLnEjzQBuCKgBIKAOpRPMGEd+1FkpPPQKRUG7MOpPlclthnI5EU24cga90fZy8=
X-Received: by 2002:a1f:bfd5:: with SMTP id p204mr1123125vkf.6.1613132456992;
 Fri, 12 Feb 2021 04:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20210209190850.16647-1-rkir@google.com>
In-Reply-To: <20210209190850.16647-1-rkir@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Feb 2021 13:20:20 +0100
Message-ID: <CAPDyKFpLZ1xry_vo-joa62TDQBiwidvZ8J8RLyK4ef_cF-Dg9A@mail.gmail.com>
Subject: Re: [PATCH] drivers: mmc: host: Retire MMC_GOLDFISH
To:     Roman Kiryanov <rkir@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Feb 2021 at 20:09, <rkir@google.com> wrote:
>
> From: Roman Kiryanov <rkir@google.com>
>
> Android Studio Emulator no longer uses
> this driver.
>
> Signed-off-by: Roman Kiryanov <rkir@google.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig            |   7 -
>  drivers/mmc/host/Makefile           |   1 -
>  drivers/mmc/host/android-goldfish.c | 545 ----------------------------
>  3 files changed, 553 deletions(-)
>  delete mode 100644 drivers/mmc/host/android-goldfish.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 596f32637315..ad4678c9bac1 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -608,13 +608,6 @@ config MMC_DAVINCI
>           If you have an DAVINCI board with a Multimedia Card slot,
>           say Y or M here.  If unsure, say N.
>
> -config MMC_GOLDFISH
> -       tristate "goldfish qemu Multimedia Card Interface support"
> -       depends on GOLDFISH || COMPILE_TEST
> -       help
> -         This selects the Goldfish Multimedia card Interface emulation
> -         found on the Goldfish Android virtual device emulation.
> -
>  config MMC_SPI
>         tristate "MMC/SD/SDIO over SPI"
>         depends on SPI_MASTER
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 451c25fc2c69..7f97e97f7066 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -34,7 +34,6 @@ obj-$(CONFIG_MMC_ATMELMCI)    +=3D atmel-mci.o
>  obj-$(CONFIG_MMC_TIFM_SD)      +=3D tifm_sd.o
>  obj-$(CONFIG_MMC_MVSDIO)       +=3D mvsdio.o
>  obj-$(CONFIG_MMC_DAVINCI)       +=3D davinci_mmc.o
> -obj-$(CONFIG_MMC_GOLDFISH)     +=3D android-goldfish.o
>  obj-$(CONFIG_MMC_SPI)          +=3D mmc_spi.o
>  ifeq ($(CONFIG_OF),y)
>  obj-$(CONFIG_MMC_SPI)          +=3D of_mmc_spi.o
> diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/andro=
id-goldfish.c
> deleted file mode 100644
> index e878fdf8f20a..000000000000
> --- a/drivers/mmc/host/android-goldfish.c
> +++ /dev/null
> @@ -1,545 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  Copyright 2007, Google Inc.
> - *  Copyright 2012, Intel Inc.
> - *
> - *  based on omap.c driver, which was
> - *  Copyright (C) 2004 Nokia Corporation
> - *  Written by Tuukka Tikkanen and Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@no=
kia.com>
> - *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
> - *  Other hacks (DMA, SD, etc) by David Brownell
> - */
> -
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/major.h>
> -
> -#include <linux/types.h>
> -#include <linux/pci.h>
> -#include <linux/interrupt.h>
> -
> -#include <linux/kernel.h>
> -#include <linux/fs.h>
> -#include <linux/errno.h>
> -#include <linux/hdreg.h>
> -#include <linux/kdev_t.h>
> -#include <linux/blkdev.h>
> -#include <linux/mutex.h>
> -#include <linux/scatterlist.h>
> -#include <linux/mmc/mmc.h>
> -#include <linux/mmc/host.h>
> -#include <linux/mmc/card.h>
> -
> -#include <linux/moduleparam.h>
> -#include <linux/init.h>
> -#include <linux/ioport.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/delay.h>
> -#include <linux/spinlock.h>
> -#include <linux/timer.h>
> -#include <linux/clk.h>
> -
> -#include <asm/io.h>
> -#include <asm/irq.h>
> -
> -#include <asm/types.h>
> -#include <linux/uaccess.h>
> -
> -#define DRIVER_NAME "goldfish_mmc"
> -
> -#define BUFFER_SIZE   16384
> -
> -#define GOLDFISH_MMC_READ(host, addr)   (readl(host->reg_base + addr))
> -#define GOLDFISH_MMC_WRITE(host, addr, x)   (writel(x, host->reg_base + =
addr))
> -
> -enum {
> -       /* status register */
> -       MMC_INT_STATUS          =3D 0x00,
> -       /* set this to enable IRQ */
> -       MMC_INT_ENABLE          =3D 0x04,
> -       /* set this to specify buffer address */
> -       MMC_SET_BUFFER          =3D 0x08,
> -
> -       /* MMC command number */
> -       MMC_CMD                 =3D 0x0C,
> -
> -       /* MMC argument */
> -       MMC_ARG                 =3D 0x10,
> -
> -       /* MMC response (or R2 bits 0 - 31) */
> -       MMC_RESP_0                      =3D 0x14,
> -
> -       /* MMC R2 response bits 32 - 63 */
> -       MMC_RESP_1                      =3D 0x18,
> -
> -       /* MMC R2 response bits 64 - 95 */
> -       MMC_RESP_2                      =3D 0x1C,
> -
> -       /* MMC R2 response bits 96 - 127 */
> -       MMC_RESP_3                      =3D 0x20,
> -
> -       MMC_BLOCK_LENGTH        =3D 0x24,
> -       MMC_BLOCK_COUNT         =3D 0x28,
> -
> -       /* MMC state flags */
> -       MMC_STATE               =3D 0x2C,
> -
> -       /* MMC_INT_STATUS bits */
> -
> -       MMC_STAT_END_OF_CMD     =3D 1U << 0,
> -       MMC_STAT_END_OF_DATA    =3D 1U << 1,
> -       MMC_STAT_STATE_CHANGE   =3D 1U << 2,
> -       MMC_STAT_CMD_TIMEOUT    =3D 1U << 3,
> -
> -       /* MMC_STATE bits */
> -       MMC_STATE_INSERTED     =3D 1U << 0,
> -       MMC_STATE_READ_ONLY    =3D 1U << 1,
> -};
> -
> -/*
> - * Command types
> - */
> -#define OMAP_MMC_CMDTYPE_BC    0
> -#define OMAP_MMC_CMDTYPE_BCR   1
> -#define OMAP_MMC_CMDTYPE_AC    2
> -#define OMAP_MMC_CMDTYPE_ADTC  3
> -
> -
> -struct goldfish_mmc_host {
> -       struct mmc_request      *mrq;
> -       struct mmc_command      *cmd;
> -       struct mmc_data         *data;
> -       struct device           *dev;
> -       unsigned char           id; /* 16xx chips have 2 MMC blocks */
> -       void                    *virt_base;
> -       unsigned int            phys_base;
> -       int                     irq;
> -       unsigned char           bus_mode;
> -       unsigned char           hw_bus_mode;
> -
> -       unsigned int            sg_len;
> -       unsigned                dma_done:1;
> -       unsigned                dma_in_use:1;
> -
> -       void __iomem            *reg_base;
> -};
> -
> -static inline int
> -goldfish_mmc_cover_is_open(struct goldfish_mmc_host *host)
> -{
> -       return 0;
> -}
> -
> -static ssize_t
> -goldfish_mmc_show_cover_switch(struct device *dev,
> -                              struct device_attribute *attr, char *buf)
> -{
> -       struct goldfish_mmc_host *host =3D dev_get_drvdata(dev);
> -
> -       return sprintf(buf, "%s\n", goldfish_mmc_cover_is_open(host) ? "o=
pen" :
> -                      "closed");
> -}
> -
> -static DEVICE_ATTR(cover_switch, S_IRUGO, goldfish_mmc_show_cover_switch=
, NULL);
> -
> -static void
> -goldfish_mmc_start_command(struct goldfish_mmc_host *host, struct mmc_co=
mmand *cmd)
> -{
> -       u32 cmdreg;
> -       u32 resptype;
> -       u32 cmdtype;
> -
> -       host->cmd =3D cmd;
> -
> -       resptype =3D 0;
> -       cmdtype =3D 0;
> -
> -       /* Our hardware needs to know exact type */
> -       switch (mmc_resp_type(cmd)) {
> -       case MMC_RSP_NONE:
> -               break;
> -       case MMC_RSP_R1:
> -       case MMC_RSP_R1B:
> -               /* resp 1, 1b, 6, 7 */
> -               resptype =3D 1;
> -               break;
> -       case MMC_RSP_R2:
> -               resptype =3D 2;
> -               break;
> -       case MMC_RSP_R3:
> -               resptype =3D 3;
> -               break;
> -       default:
> -               dev_err(mmc_dev(mmc_from_priv(host)),
> -                       "Invalid response type: %04x\n", mmc_resp_type(cm=
d));
> -               break;
> -       }
> -
> -       if (mmc_cmd_type(cmd) =3D=3D MMC_CMD_ADTC)
> -               cmdtype =3D OMAP_MMC_CMDTYPE_ADTC;
> -       else if (mmc_cmd_type(cmd) =3D=3D MMC_CMD_BC)
> -               cmdtype =3D OMAP_MMC_CMDTYPE_BC;
> -       else if (mmc_cmd_type(cmd) =3D=3D MMC_CMD_BCR)
> -               cmdtype =3D OMAP_MMC_CMDTYPE_BCR;
> -       else
> -               cmdtype =3D OMAP_MMC_CMDTYPE_AC;
> -
> -       cmdreg =3D cmd->opcode | (resptype << 8) | (cmdtype << 12);
> -
> -       if (host->bus_mode =3D=3D MMC_BUSMODE_OPENDRAIN)
> -               cmdreg |=3D 1 << 6;
> -
> -       if (cmd->flags & MMC_RSP_BUSY)
> -               cmdreg |=3D 1 << 11;
> -
> -       if (host->data && !(host->data->flags & MMC_DATA_WRITE))
> -               cmdreg |=3D 1 << 15;
> -
> -       GOLDFISH_MMC_WRITE(host, MMC_ARG, cmd->arg);
> -       GOLDFISH_MMC_WRITE(host, MMC_CMD, cmdreg);
> -}
> -
> -static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
> -                                  struct mmc_data *data)
> -{
> -       if (host->dma_in_use) {
> -               enum dma_data_direction dma_data_dir;
> -
> -               dma_data_dir =3D mmc_get_dma_dir(data);
> -
> -               if (dma_data_dir =3D=3D DMA_FROM_DEVICE) {
> -                       /*
> -                        * We don't really have DMA, so we need
> -                        * to copy from our platform driver buffer
> -                        */
> -                       sg_copy_from_buffer(data->sg, 1, host->virt_base,
> -                                       data->sg->length);
> -               }
> -               host->data->bytes_xfered +=3D data->sg->length;
> -               dma_unmap_sg(mmc_dev(mmc_from_priv(host)), data->sg,
> -                            host->sg_len, dma_data_dir);
> -       }
> -
> -       host->data =3D NULL;
> -       host->sg_len =3D 0;
> -
> -       /*
> -        * NOTE:  MMC layer will sometimes poll-wait CMD13 next, issuing
> -        * dozens of requests until the card finishes writing data.
> -        * It'd be cheaper to just wait till an EOFB interrupt arrives...
> -        */
> -
> -       if (!data->stop) {
> -               host->mrq =3D NULL;
> -               mmc_request_done(mmc_from_priv(host), data->mrq);
> -               return;
> -       }
> -
> -       goldfish_mmc_start_command(host, data->stop);
> -}
> -
> -static void goldfish_mmc_end_of_data(struct goldfish_mmc_host *host,
> -                                    struct mmc_data *data)
> -{
> -       if (!host->dma_in_use) {
> -               goldfish_mmc_xfer_done(host, data);
> -               return;
> -       }
> -       if (host->dma_done)
> -               goldfish_mmc_xfer_done(host, data);
> -}
> -
> -static void goldfish_mmc_cmd_done(struct goldfish_mmc_host *host,
> -                                 struct mmc_command *cmd)
> -{
> -       host->cmd =3D NULL;
> -       if (cmd->flags & MMC_RSP_PRESENT) {
> -               if (cmd->flags & MMC_RSP_136) {
> -                       /* response type 2 */
> -                       cmd->resp[3] =3D
> -                               GOLDFISH_MMC_READ(host, MMC_RESP_0);
> -                       cmd->resp[2] =3D
> -                               GOLDFISH_MMC_READ(host, MMC_RESP_1);
> -                       cmd->resp[1] =3D
> -                               GOLDFISH_MMC_READ(host, MMC_RESP_2);
> -                       cmd->resp[0] =3D
> -                               GOLDFISH_MMC_READ(host, MMC_RESP_3);
> -               } else {
> -                       /* response types 1, 1b, 3, 4, 5, 6 */
> -                       cmd->resp[0] =3D
> -                               GOLDFISH_MMC_READ(host, MMC_RESP_0);
> -               }
> -       }
> -
> -       if (host->data =3D=3D NULL || cmd->error) {
> -               host->mrq =3D NULL;
> -               mmc_request_done(mmc_from_priv(host), cmd->mrq);
> -       }
> -}
> -
> -static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
> -{
> -       struct goldfish_mmc_host *host =3D (struct goldfish_mmc_host *)de=
v_id;
> -       u16 status;
> -       int end_command =3D 0;
> -       int end_transfer =3D 0;
> -       int state_changed =3D 0;
> -       int cmd_timeout =3D 0;
> -
> -       while ((status =3D GOLDFISH_MMC_READ(host, MMC_INT_STATUS)) !=3D =
0) {
> -               GOLDFISH_MMC_WRITE(host, MMC_INT_STATUS, status);
> -
> -               if (status & MMC_STAT_END_OF_CMD)
> -                       end_command =3D 1;
> -
> -               if (status & MMC_STAT_END_OF_DATA)
> -                       end_transfer =3D 1;
> -
> -               if (status & MMC_STAT_STATE_CHANGE)
> -                       state_changed =3D 1;
> -
> -                if (status & MMC_STAT_CMD_TIMEOUT) {
> -                       end_command =3D 0;
> -                       cmd_timeout =3D 1;
> -                }
> -       }
> -
> -       if (cmd_timeout) {
> -               struct mmc_request *mrq =3D host->mrq;
> -               mrq->cmd->error =3D -ETIMEDOUT;
> -               host->mrq =3D NULL;
> -               mmc_request_done(mmc_from_priv(host), mrq);
> -       }
> -
> -       if (end_command)
> -               goldfish_mmc_cmd_done(host, host->cmd);
> -
> -       if (end_transfer) {
> -               host->dma_done =3D 1;
> -               goldfish_mmc_end_of_data(host, host->data);
> -       } else if (host->data !=3D NULL) {
> -               /*
> -                * WORKAROUND -- after porting this driver from 2.6 to 3.=
4,
> -                * during device initialization, cases where host->data i=
s
> -                * non-null but end_transfer is false would occur. Doing
> -                * nothing in such cases results in no further interrupts=
,
> -                * and initialization failure.
> -                * TODO -- find the real cause.
> -                */
> -               host->dma_done =3D 1;
> -               goldfish_mmc_end_of_data(host, host->data);
> -       }
> -
> -       if (state_changed) {
> -               u32 state =3D GOLDFISH_MMC_READ(host, MMC_STATE);
> -               pr_info("%s: Card detect now %d\n", __func__,
> -                       (state & MMC_STATE_INSERTED));
> -               mmc_detect_change(mmc_from_priv(host), 0);
> -       }
> -
> -       if (!end_command && !end_transfer && !state_changed && !cmd_timeo=
ut) {
> -               status =3D GOLDFISH_MMC_READ(host, MMC_INT_STATUS);
> -               dev_info(mmc_dev(mmc_from_priv(host)), "spurious irq 0x%0=
4x\n",
> -                        status);
> -               if (status !=3D 0) {
> -                       GOLDFISH_MMC_WRITE(host, MMC_INT_STATUS, status);
> -                       GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE, 0);
> -               }
> -       }
> -
> -       return IRQ_HANDLED;
> -}
> -
> -static void goldfish_mmc_prepare_data(struct goldfish_mmc_host *host,
> -                                     struct mmc_request *req)
> -{
> -       struct mmc_data *data =3D req->data;
> -       int block_size;
> -       unsigned sg_len;
> -       enum dma_data_direction dma_data_dir;
> -
> -       host->data =3D data;
> -       if (data =3D=3D NULL) {
> -               GOLDFISH_MMC_WRITE(host, MMC_BLOCK_LENGTH, 0);
> -               GOLDFISH_MMC_WRITE(host, MMC_BLOCK_COUNT, 0);
> -               host->dma_in_use =3D 0;
> -               return;
> -       }
> -
> -       block_size =3D data->blksz;
> -
> -       GOLDFISH_MMC_WRITE(host, MMC_BLOCK_COUNT, data->blocks - 1);
> -       GOLDFISH_MMC_WRITE(host, MMC_BLOCK_LENGTH, block_size - 1);
> -
> -       /*
> -        * Cope with calling layer confusion; it issues "single
> -        * block" writes using multi-block scatterlists.
> -        */
> -       sg_len =3D (data->blocks =3D=3D 1) ? 1 : data->sg_len;
> -
> -       dma_data_dir =3D mmc_get_dma_dir(data);
> -
> -       host->sg_len =3D dma_map_sg(mmc_dev(mmc_from_priv(host)), data->s=
g,
> -                                 sg_len, dma_data_dir);
> -       host->dma_done =3D 0;
> -       host->dma_in_use =3D 1;
> -
> -       if (dma_data_dir =3D=3D DMA_TO_DEVICE) {
> -               /*
> -                * We don't really have DMA, so we need to copy to our
> -                * platform driver buffer
> -                */
> -               sg_copy_to_buffer(data->sg, 1, host->virt_base,
> -                               data->sg->length);
> -       }
> -}
> -
> -static void goldfish_mmc_request(struct mmc_host *mmc, struct mmc_reques=
t *req)
> -{
> -       struct goldfish_mmc_host *host =3D mmc_priv(mmc);
> -
> -       WARN_ON(host->mrq !=3D NULL);
> -
> -       host->mrq =3D req;
> -       goldfish_mmc_prepare_data(host, req);
> -       goldfish_mmc_start_command(host, req->cmd);
> -}
> -
> -static void goldfish_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *i=
os)
> -{
> -       struct goldfish_mmc_host *host =3D mmc_priv(mmc);
> -
> -       host->bus_mode =3D ios->bus_mode;
> -       host->hw_bus_mode =3D host->bus_mode;
> -}
> -
> -static int goldfish_mmc_get_ro(struct mmc_host *mmc)
> -{
> -       uint32_t state;
> -       struct goldfish_mmc_host *host =3D mmc_priv(mmc);
> -
> -       state =3D GOLDFISH_MMC_READ(host, MMC_STATE);
> -       return ((state & MMC_STATE_READ_ONLY) !=3D 0);
> -}
> -
> -static const struct mmc_host_ops goldfish_mmc_ops =3D {
> -       .request        =3D goldfish_mmc_request,
> -       .set_ios        =3D goldfish_mmc_set_ios,
> -       .get_ro         =3D goldfish_mmc_get_ro,
> -};
> -
> -static int goldfish_mmc_probe(struct platform_device *pdev)
> -{
> -       struct mmc_host *mmc;
> -       struct goldfish_mmc_host *host =3D NULL;
> -       struct resource *res;
> -       int ret =3D 0;
> -       int irq;
> -       dma_addr_t buf_addr;
> -
> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       irq =3D platform_get_irq(pdev, 0);
> -       if (res =3D=3D NULL || irq < 0)
> -               return -ENXIO;
> -
> -       mmc =3D mmc_alloc_host(sizeof(struct goldfish_mmc_host), &pdev->d=
ev);
> -       if (mmc =3D=3D NULL) {
> -               ret =3D -ENOMEM;
> -               goto err_alloc_host_failed;
> -       }
> -
> -       host =3D mmc_priv(mmc);
> -
> -       pr_err("mmc: Mapping %lX to %lX\n", (long)res->start, (long)res->=
end);
> -       host->reg_base =3D ioremap(res->start, resource_size(res));
> -       if (host->reg_base =3D=3D NULL) {
> -               ret =3D -ENOMEM;
> -               goto ioremap_failed;
> -       }
> -       host->virt_base =3D dma_alloc_coherent(&pdev->dev, BUFFER_SIZE,
> -                                            &buf_addr, GFP_KERNEL);
> -
> -       if (host->virt_base =3D=3D 0) {
> -               ret =3D -ENOMEM;
> -               goto dma_alloc_failed;
> -       }
> -       host->phys_base =3D buf_addr;
> -
> -       host->id =3D pdev->id;
> -       host->irq =3D irq;
> -
> -       mmc->ops =3D &goldfish_mmc_ops;
> -       mmc->f_min =3D 400000;
> -       mmc->f_max =3D 24000000;
> -       mmc->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
> -       mmc->caps =3D MMC_CAP_4_BIT_DATA;
> -       mmc->caps2 =3D MMC_CAP2_NO_SDIO;
> -
> -       /* Use scatterlist DMA to reduce per-transfer costs.
> -        * NOTE max_seg_size assumption that small blocks aren't
> -        * normally used (except e.g. for reading SD registers).
> -        */
> -       mmc->max_segs =3D 32;
> -       mmc->max_blk_size =3D 2048;       /* MMC_BLOCK_LENGTH is 11 bits =
(+1) */
> -       mmc->max_blk_count =3D 2048;      /* MMC_BLOCK_COUNT is 11 bits (=
+1) */
> -       mmc->max_req_size =3D BUFFER_SIZE;
> -       mmc->max_seg_size =3D mmc->max_req_size;
> -
> -       ret =3D request_irq(host->irq, goldfish_mmc_irq, 0, DRIVER_NAME, =
host);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Failed IRQ Adding goldfish MMC\n");
> -               goto err_request_irq_failed;
> -       }
> -
> -       host->dev =3D &pdev->dev;
> -       platform_set_drvdata(pdev, host);
> -
> -       ret =3D device_create_file(&pdev->dev, &dev_attr_cover_switch);
> -       if (ret)
> -               dev_warn(mmc_dev(mmc), "Unable to create sysfs attributes=
\n");
> -
> -       GOLDFISH_MMC_WRITE(host, MMC_SET_BUFFER, host->phys_base);
> -       GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE,
> -                          MMC_STAT_END_OF_CMD | MMC_STAT_END_OF_DATA |
> -                          MMC_STAT_STATE_CHANGE | MMC_STAT_CMD_TIMEOUT);
> -
> -       mmc_add_host(mmc);
> -       return 0;
> -
> -err_request_irq_failed:
> -       dma_free_coherent(&pdev->dev, BUFFER_SIZE, host->virt_base,
> -                         host->phys_base);
> -dma_alloc_failed:
> -       iounmap(host->reg_base);
> -ioremap_failed:
> -       mmc_free_host(mmc);
> -err_alloc_host_failed:
> -       return ret;
> -}
> -
> -static int goldfish_mmc_remove(struct platform_device *pdev)
> -{
> -       struct goldfish_mmc_host *host =3D platform_get_drvdata(pdev);
> -       struct mmc_host *mmc =3D mmc_from_priv(host);
> -
> -       BUG_ON(host =3D=3D NULL);
> -
> -       mmc_remove_host(mmc);
> -       free_irq(host->irq, host);
> -       dma_free_coherent(&pdev->dev, BUFFER_SIZE, host->virt_base, host-=
>phys_base);
> -       iounmap(host->reg_base);
> -       mmc_free_host(mmc);
> -       return 0;
> -}
> -
> -static struct platform_driver goldfish_mmc_driver =3D {
> -       .probe          =3D goldfish_mmc_probe,
> -       .remove         =3D goldfish_mmc_remove,
> -       .driver         =3D {
> -               .name   =3D DRIVER_NAME,
> -               .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> -       },
> -};
> -
> -module_platform_driver(goldfish_mmc_driver);
> -MODULE_LICENSE("GPL v2");
> --
> 2.30.0.478.g8a0d178c01-goog
>
