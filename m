Return-Path: <linux-mmc+bounces-2745-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D91910954
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Jun 2024 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6BF2828FB
	for <lists+linux-mmc@lfdr.de>; Thu, 20 Jun 2024 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A91AF687;
	Thu, 20 Jun 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgBI4Tr6"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBB1AE0B3
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896156; cv=none; b=Jw5iFVjQauqFwE9JF3mJJAKpb2ohW1N611OBp3fI9TnMV9wp1XijM8hWYo0S7TPhSYRVJz6WmFZwBfKzb+1kewXAjYiRMuMQTOEWKBscZJ3y2FCQuHnW38NKTPP/SGDKkFkURrU9jacgPNphRhLuXUBnIQcxtmpy1s5gn/wbopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896156; c=relaxed/simple;
	bh=azcVgzfGwOQoRF6a1NH5Hi6UV6ivO2g45HTxX4JAAB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8ldW+U5QxAfdcfOGUpUh70YPDTqYkxHc9rP9+KYpUEhSN0TJn4YCEoFPg+SxWeIQWfWApot0g+MHPdCeaR6mUEkxUYBRE5H2WYfSh2syn6/tzpEGLcArd/SxH3Q6xNz8lEB+kmHdnPJt8xz/0woTznmeK/SmCStCogot/USTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rgBI4Tr6; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfe81d54db9so993370276.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896152; x=1719500952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXtP2F9o1KrkIrC5BAIZ7qrV41TEqa6/iN/9q89a4nc=;
        b=rgBI4Tr67uEe9XaYX2FDDSK1jxanTECUZbgoIsaBYZ9PNoITa4hkoLDsuYGkNXrjC3
         oMqLQkCdkQJryn67vEReEbS3e3RTn2GD6BuYZoFLpWeN7zhwYpNTrZLQiR9lkfSXv54d
         KZTYrwAWt7CFvZ72gPRUsdPPNOM1TbN9AnIp9VauYHu2tOtEnqOUuyuT5dezmxBq+slr
         Ko/CXpXhAqfwMbtfhUwItSvKWae2sP19JcVZkY1nCgVrhlvLkIem5QabxdSpKoajuiqE
         r7F9bdWBLtlKYT8m6HCJ+RkWw858qSdpVpz1CUpUTtIxy+YkNav6OoCeBOsBMI9ULgBy
         O+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896152; x=1719500952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXtP2F9o1KrkIrC5BAIZ7qrV41TEqa6/iN/9q89a4nc=;
        b=FJkEwH/6fIa09bJVGngbpFA2di8IawL2WS31LXJABBs5sjmQ+YIbb3ShCFAcXMkTDd
         intY+EWPt1nAx7JZt1LWVrDDgXuXOzELcl1cfHhL4VKwhNdWCFHCZuvkl4mtWQ3Bap4M
         hRc7qehOuiemtRwYa4I5Y9tWYjmzc7YnIrMS16A4nTxvdacnNB+i8QmMzpisdtQsBjRa
         E6OtBj8iJEIkxkaQ1kF0aKDLsxzPg4Se9EExPryv9A3eJgPUSfpiyzjaHGPbSjHjRmiM
         Nxh0P4LV6Fyj0fVE54QEVqOCrZPcc5DYrlV1+tJvUQnfdqJ7KSxbaZKhYpwaWGg5nbiV
         eJyA==
X-Forwarded-Encrypted: i=1; AJvYcCVtoCczFAj1YhQuZsu4ogrZ0/QjKZO1pGDgc6No4ZVc3JCweA/kVc7Ux/ZY3gAfZ/My9VP2hHg6gaVmTWWWT8FPu84TDF1Pboso
X-Gm-Message-State: AOJu0YzjHL5rPdXCNrdRXUIGX0gdYFmSS/oQKXOCuijjOLk1BloUF+I1
	ZqMGn/ol/5lXNsPlyykLGnp5iRWMqZgxgRvXd8ldlZ1AIWqZGP4hRx5vHlAxvDcKIyujXGuhxk2
	lDdVTKJD72PWUeawJhscWKyGZjMJgqX6QEeXY+g==
X-Google-Smtp-Source: AGHT+IF4kJ8Oc7hfsjYPwkilCSSJqpwHLm8qvp26Nd9XsNC1BbexDjR6gURpycPSh+8q+BDfX7w5F4x69W4va/Hbon0=
X-Received: by 2002:a25:df89:0:b0:dfa:b64b:48bd with SMTP id
 3f1490d57ef6-e02be0fc58bmr5706579276.1.1718896152103; Thu, 20 Jun 2024
 08:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620031159.142637-1-kai.heng.feng@canonical.com>
In-Reply-To: <20240620031159.142637-1-kai.heng.feng@canonical.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 17:08:36 +0200
Message-ID: <CAPDyKFq9EEmnT1D3qW3+MiFMpCQABEn1TqCG5if0MEzacdwVmA@mail.gmail.com>
Subject: Re: [PATCH] memstick: rtsx_pci_ms: Remove Realtek PCI memstick driver
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, Micky Ching <micky_ching@realsil.com.cn>, 
	Wei WANG <wei_wang@realsil.com.cn>, Rui Feng <rui_feng@realsil.com.cn>
Cc: maximlevitsky@gmail.com, oakad@yahoo.com, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 05:12, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> Commit c0e5f4e73a71 ("misc: rtsx: Add support for RTS5261") silently
> removed RTSX_MS_CARD from its MFD cell, so rtsx_pci_ms isn't used
> by any driver anymore.
>
> Since there doesn't seem to any complaint, hence drop the driver.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Not sure if anybody is using memstick at all these days, but who knows. :-)

Anyway, I have tried to loop in some of the driver authors. Let's
allow another week before we take the final decision on how to move
forward.

Kind regards
Uffe


> ---
>  drivers/memstick/host/Kconfig       |  10 -
>  drivers/memstick/host/Makefile      |   1 -
>  drivers/memstick/host/rtsx_pci_ms.c | 638 ----------------------------
>  3 files changed, 649 deletions(-)
>  delete mode 100644 drivers/memstick/host/rtsx_pci_ms.c
>
> diff --git a/drivers/memstick/host/Kconfig b/drivers/memstick/host/Kconfig
> index 4113343da056..fcd2c2cc3cb4 100644
> --- a/drivers/memstick/host/Kconfig
> +++ b/drivers/memstick/host/Kconfig
> @@ -44,16 +44,6 @@ config MEMSTICK_R592
>           To compile this driver as a module, choose M here: the module will
>           be called r592.
>
> -config MEMSTICK_REALTEK_PCI
> -       tristate "Realtek PCI-E Memstick Card Interface Driver"
> -       depends on MISC_RTSX_PCI
> -       help
> -         Say Y here to include driver code to support Memstick card interface
> -         of Realtek PCI-E card reader
> -
> -         To compile this driver as a module, choose M here: the module will
> -         be called rtsx_pci_ms.
> -
>  config MEMSTICK_REALTEK_USB
>         tristate "Realtek USB Memstick Card Interface Driver"
>         depends on MISC_RTSX_USB
> diff --git a/drivers/memstick/host/Makefile b/drivers/memstick/host/Makefile
> index 1abaa03ee68c..0c90df33165d 100644
> --- a/drivers/memstick/host/Makefile
> +++ b/drivers/memstick/host/Makefile
> @@ -6,5 +6,4 @@
>  obj-$(CONFIG_MEMSTICK_TIFM_MS)         += tifm_ms.o
>  obj-$(CONFIG_MEMSTICK_JMICRON_38X)     += jmb38x_ms.o
>  obj-$(CONFIG_MEMSTICK_R592)            += r592.o
> -obj-$(CONFIG_MEMSTICK_REALTEK_PCI)     += rtsx_pci_ms.o
>  obj-$(CONFIG_MEMSTICK_REALTEK_USB)     += rtsx_usb_ms.o
> diff --git a/drivers/memstick/host/rtsx_pci_ms.c b/drivers/memstick/host/rtsx_pci_ms.c
> deleted file mode 100644
> index 980a54513e6c..000000000000
> --- a/drivers/memstick/host/rtsx_pci_ms.c
> +++ /dev/null
> @@ -1,638 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/* Realtek PCI-Express Memstick Card Interface driver
> - *
> - * Copyright(c) 2009-2013 Realtek Semiconductor Corp. All rights reserved.
> - *
> - * Author:
> - *   Wei WANG <wei_wang@realsil.com.cn>
> - */
> -
> -#include <linux/module.h>
> -#include <linux/highmem.h>
> -#include <linux/delay.h>
> -#include <linux/platform_device.h>
> -#include <linux/memstick.h>
> -#include <linux/rtsx_pci.h>
> -#include <asm/unaligned.h>
> -
> -struct realtek_pci_ms {
> -       struct platform_device  *pdev;
> -       struct rtsx_pcr         *pcr;
> -       struct memstick_host    *msh;
> -       struct memstick_request *req;
> -
> -       struct mutex            host_mutex;
> -       struct work_struct      handle_req;
> -
> -       u8                      ssc_depth;
> -       unsigned int            clock;
> -       unsigned char           ifmode;
> -       bool                    eject;
> -};
> -
> -static inline struct device *ms_dev(struct realtek_pci_ms *host)
> -{
> -       return &(host->pdev->dev);
> -}
> -
> -static inline void ms_clear_error(struct realtek_pci_ms *host)
> -{
> -       rtsx_pci_write_register(host->pcr, CARD_STOP,
> -                       MS_STOP | MS_CLR_ERR, MS_STOP | MS_CLR_ERR);
> -}
> -
> -#ifdef DEBUG
> -
> -static void ms_print_debug_regs(struct realtek_pci_ms *host)
> -{
> -       struct rtsx_pcr *pcr = host->pcr;
> -       u16 i;
> -       u8 *ptr;
> -
> -       /* Print MS host internal registers */
> -       rtsx_pci_init_cmd(pcr);
> -       for (i = 0xFD40; i <= 0xFD44; i++)
> -               rtsx_pci_add_cmd(pcr, READ_REG_CMD, i, 0, 0);
> -       for (i = 0xFD52; i <= 0xFD69; i++)
> -               rtsx_pci_add_cmd(pcr, READ_REG_CMD, i, 0, 0);
> -       rtsx_pci_send_cmd(pcr, 100);
> -
> -       ptr = rtsx_pci_get_cmd_data(pcr);
> -       for (i = 0xFD40; i <= 0xFD44; i++)
> -               dev_dbg(ms_dev(host), "0x%04X: 0x%02x\n", i, *(ptr++));
> -       for (i = 0xFD52; i <= 0xFD69; i++)
> -               dev_dbg(ms_dev(host), "0x%04X: 0x%02x\n", i, *(ptr++));
> -}
> -
> -#else
> -
> -#define ms_print_debug_regs(host)
> -
> -#endif
> -
> -static int ms_power_on(struct realtek_pci_ms *host)
> -{
> -       struct rtsx_pcr *pcr = host->pcr;
> -       int err;
> -
> -       rtsx_pci_init_cmd(pcr);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SELECT, 0x07, MS_MOD_SEL);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SHARE_MODE,
> -                       CARD_SHARE_MASK, CARD_SHARE_48_MS);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_CLK_EN,
> -                       MS_CLK_EN, MS_CLK_EN);
> -       err = rtsx_pci_send_cmd(pcr, 100);
> -       if (err < 0)
> -               return err;
> -
> -       err = rtsx_pci_card_pull_ctl_enable(pcr, RTSX_MS_CARD);
> -       if (err < 0)
> -               return err;
> -
> -       err = rtsx_pci_card_power_on(pcr, RTSX_MS_CARD);
> -       if (err < 0)
> -               return err;
> -
> -       /* Wait ms power stable */
> -       msleep(150);
> -
> -       err = rtsx_pci_write_register(pcr, CARD_OE,
> -                       MS_OUTPUT_EN, MS_OUTPUT_EN);
> -       if (err < 0)
> -               return err;
> -
> -       return 0;
> -}
> -
> -static int ms_power_off(struct realtek_pci_ms *host)
> -{
> -       struct rtsx_pcr *pcr = host->pcr;
> -       int err;
> -
> -       rtsx_pci_init_cmd(pcr);
> -
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_CLK_EN, MS_CLK_EN, 0);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_OE, MS_OUTPUT_EN, 0);
> -
> -       err = rtsx_pci_send_cmd(pcr, 100);
> -       if (err < 0)
> -               return err;
> -
> -       err = rtsx_pci_card_power_off(pcr, RTSX_MS_CARD);
> -       if (err < 0)
> -               return err;
> -
> -       return rtsx_pci_card_pull_ctl_disable(pcr, RTSX_MS_CARD);
> -}
> -
> -static int ms_transfer_data(struct realtek_pci_ms *host, unsigned char data_dir,
> -               u8 tpc, u8 cfg, struct scatterlist *sg)
> -{
> -       struct rtsx_pcr *pcr = host->pcr;
> -       int err;
> -       unsigned int length = sg->length;
> -       u16 sec_cnt = (u16)(length / 512);
> -       u8 val, trans_mode, dma_dir;
> -       struct memstick_dev *card = host->msh->card;
> -       bool pro_card = card->id.type == MEMSTICK_TYPE_PRO;
> -
> -       dev_dbg(ms_dev(host), "%s: tpc = 0x%02x, data_dir = %s, length = %d\n",
> -                       __func__, tpc, (data_dir == READ) ? "READ" : "WRITE",
> -                       length);
> -
> -       if (data_dir == READ) {
> -               dma_dir = DMA_DIR_FROM_CARD;
> -               trans_mode = pro_card ? MS_TM_AUTO_READ : MS_TM_NORMAL_READ;
> -       } else {
> -               dma_dir = DMA_DIR_TO_CARD;
> -               trans_mode = pro_card ? MS_TM_AUTO_WRITE : MS_TM_NORMAL_WRITE;
> -       }
> -
> -       rtsx_pci_init_cmd(pcr);
> -
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_TPC, 0xFF, tpc);
> -       if (pro_card) {
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_SECTOR_CNT_H,
> -                               0xFF, (u8)(sec_cnt >> 8));
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_SECTOR_CNT_L,
> -                               0xFF, (u8)sec_cnt);
> -       }
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF, cfg);
> -
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, IRQSTAT0,
> -                       DMA_DONE_INT, DMA_DONE_INT);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC3, 0xFF, (u8)(length >> 24));
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC2, 0xFF, (u8)(length >> 16));
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC1, 0xFF, (u8)(length >> 8));
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMATC0, 0xFF, (u8)length);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, DMACTL,
> -                       0x03 | DMA_PACK_SIZE_MASK, dma_dir | DMA_EN | DMA_512);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_DATA_SOURCE,
> -                       0x01, RING_BUFFER);
> -
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_TRANSFER,
> -                       0xFF, MS_TRANSFER_START | trans_mode);
> -       rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, MS_TRANSFER,
> -                       MS_TRANSFER_END, MS_TRANSFER_END);
> -
> -       rtsx_pci_send_cmd_no_wait(pcr);
> -
> -       err = rtsx_pci_transfer_data(pcr, sg, 1, data_dir == READ, 10000);
> -       if (err < 0) {
> -               ms_clear_error(host);
> -               return err;
> -       }
> -
> -       rtsx_pci_read_register(pcr, MS_TRANS_CFG, &val);
> -       if (pro_card) {
> -               if (val & (MS_INT_CMDNK | MS_INT_ERR |
> -                               MS_CRC16_ERR | MS_RDY_TIMEOUT))
> -                       return -EIO;
> -       } else {
> -               if (val & (MS_CRC16_ERR | MS_RDY_TIMEOUT))
> -                       return -EIO;
> -       }
> -
> -       return 0;
> -}
> -
> -static int ms_write_bytes(struct realtek_pci_ms *host, u8 tpc,
> -               u8 cfg, u8 cnt, u8 *data, u8 *int_reg)
> -{
> -       struct rtsx_pcr *pcr = host->pcr;
> -       int err, i;
> -
> -       dev_dbg(ms_dev(host), "%s: tpc = 0x%02x\n", __func__, tpc);
> -
> -       if (!data)
> -               return -EINVAL;
> -
> -       rtsx_pci_init_cmd(pcr);
> -
> -       for (i = 0; i < cnt; i++)
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD,
> -                               PPBUF_BASE2 + i, 0xFF, data[i]);
> -       if (cnt % 2)
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD,
> -                               PPBUF_BASE2 + i, 0xFF, 0xFF);
> -
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_TPC, 0xFF, tpc);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_BYTE_CNT, 0xFF, cnt);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF, cfg);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_DATA_SOURCE,
> -                       0x01, PINGPONG_BUFFER);
> -
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_TRANSFER,
> -                       0xFF, MS_TRANSFER_START | MS_TM_WRITE_BYTES);
> -       rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, MS_TRANSFER,
> -                       MS_TRANSFER_END, MS_TRANSFER_END);
> -       if (int_reg)
> -               rtsx_pci_add_cmd(pcr, READ_REG_CMD, MS_TRANS_CFG, 0, 0);
> -
> -       err = rtsx_pci_send_cmd(pcr, 5000);
> -       if (err < 0) {
> -               u8 val;
> -
> -               rtsx_pci_read_register(pcr, MS_TRANS_CFG, &val);
> -               dev_dbg(ms_dev(host), "MS_TRANS_CFG: 0x%02x\n", val);
> -
> -               if (int_reg)
> -                       *int_reg = val & 0x0F;
> -
> -               ms_print_debug_regs(host);
> -
> -               ms_clear_error(host);
> -
> -               if (!(tpc & 0x08)) {
> -                       if (val & MS_CRC16_ERR)
> -                               return -EIO;
> -               } else {
> -                       if (!(val & 0x80)) {
> -                               if (val & (MS_INT_ERR | MS_INT_CMDNK))
> -                                       return -EIO;
> -                       }
> -               }
> -
> -               return -ETIMEDOUT;
> -       }
> -
> -       if (int_reg) {
> -               u8 *ptr = rtsx_pci_get_cmd_data(pcr) + 1;
> -               *int_reg = *ptr & 0x0F;
> -       }
> -
> -       return 0;
> -}
> -
> -static int ms_read_bytes(struct realtek_pci_ms *host, u8 tpc,
> -               u8 cfg, u8 cnt, u8 *data, u8 *int_reg)
> -{
> -       struct rtsx_pcr *pcr = host->pcr;
> -       int err, i;
> -       u8 *ptr;
> -
> -       dev_dbg(ms_dev(host), "%s: tpc = 0x%02x\n", __func__, tpc);
> -
> -       if (!data)
> -               return -EINVAL;
> -
> -       rtsx_pci_init_cmd(pcr);
> -
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_TPC, 0xFF, tpc);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_BYTE_CNT, 0xFF, cnt);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF, cfg);
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_DATA_SOURCE,
> -                       0x01, PINGPONG_BUFFER);
> -
> -       rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, MS_TRANSFER,
> -                       0xFF, MS_TRANSFER_START | MS_TM_READ_BYTES);
> -       rtsx_pci_add_cmd(pcr, CHECK_REG_CMD, MS_TRANSFER,
> -                       MS_TRANSFER_END, MS_TRANSFER_END);
> -       for (i = 0; i < cnt - 1; i++)
> -               rtsx_pci_add_cmd(pcr, READ_REG_CMD, PPBUF_BASE2 + i, 0, 0);
> -       if (cnt % 2)
> -               rtsx_pci_add_cmd(pcr, READ_REG_CMD, PPBUF_BASE2 + cnt, 0, 0);
> -       else
> -               rtsx_pci_add_cmd(pcr, READ_REG_CMD,
> -                               PPBUF_BASE2 + cnt - 1, 0, 0);
> -       if (int_reg)
> -               rtsx_pci_add_cmd(pcr, READ_REG_CMD, MS_TRANS_CFG, 0, 0);
> -
> -       err = rtsx_pci_send_cmd(pcr, 5000);
> -       if (err < 0) {
> -               u8 val;
> -
> -               rtsx_pci_read_register(pcr, MS_TRANS_CFG, &val);
> -               dev_dbg(ms_dev(host), "MS_TRANS_CFG: 0x%02x\n", val);
> -
> -               if (int_reg)
> -                       *int_reg = val & 0x0F;
> -
> -               ms_print_debug_regs(host);
> -
> -               ms_clear_error(host);
> -
> -               if (!(tpc & 0x08)) {
> -                       if (val & MS_CRC16_ERR)
> -                               return -EIO;
> -               } else {
> -                       if (!(val & 0x80)) {
> -                               if (val & (MS_INT_ERR | MS_INT_CMDNK))
> -                                       return -EIO;
> -                       }
> -               }
> -
> -               return -ETIMEDOUT;
> -       }
> -
> -       ptr = rtsx_pci_get_cmd_data(pcr) + 1;
> -       for (i = 0; i < cnt; i++)
> -               data[i] = *ptr++;
> -
> -       if (int_reg)
> -               *int_reg = *ptr & 0x0F;
> -
> -       return 0;
> -}
> -
> -static int rtsx_pci_ms_issue_cmd(struct realtek_pci_ms *host)
> -{
> -       struct memstick_request *req = host->req;
> -       int err = 0;
> -       u8 cfg = 0, int_reg;
> -
> -       dev_dbg(ms_dev(host), "%s\n", __func__);
> -
> -       if (req->need_card_int) {
> -               if (host->ifmode != MEMSTICK_SERIAL)
> -                       cfg = WAIT_INT;
> -       }
> -
> -       if (req->long_data) {
> -               err = ms_transfer_data(host, req->data_dir,
> -                               req->tpc, cfg, &(req->sg));
> -       } else {
> -               if (req->data_dir == READ) {
> -                       err = ms_read_bytes(host, req->tpc, cfg,
> -                                       req->data_len, req->data, &int_reg);
> -               } else {
> -                       err = ms_write_bytes(host, req->tpc, cfg,
> -                                       req->data_len, req->data, &int_reg);
> -               }
> -       }
> -       if (err < 0)
> -               return err;
> -
> -       if (req->need_card_int && (host->ifmode == MEMSTICK_SERIAL)) {
> -               err = ms_read_bytes(host, MS_TPC_GET_INT,
> -                               NO_WAIT_INT, 1, &int_reg, NULL);
> -               if (err < 0)
> -                       return err;
> -       }
> -
> -       if (req->need_card_int) {
> -               dev_dbg(ms_dev(host), "int_reg: 0x%02x\n", int_reg);
> -
> -               if (int_reg & MS_INT_CMDNK)
> -                       req->int_reg |= MEMSTICK_INT_CMDNAK;
> -               if (int_reg & MS_INT_BREQ)
> -                       req->int_reg |= MEMSTICK_INT_BREQ;
> -               if (int_reg & MS_INT_ERR)
> -                       req->int_reg |= MEMSTICK_INT_ERR;
> -               if (int_reg & MS_INT_CED)
> -                       req->int_reg |= MEMSTICK_INT_CED;
> -       }
> -
> -       return 0;
> -}
> -
> -static void rtsx_pci_ms_handle_req(struct work_struct *work)
> -{
> -       struct realtek_pci_ms *host = container_of(work,
> -                       struct realtek_pci_ms, handle_req);
> -       struct rtsx_pcr *pcr = host->pcr;
> -       struct memstick_host *msh = host->msh;
> -       int rc;
> -
> -       mutex_lock(&pcr->pcr_mutex);
> -
> -       rtsx_pci_start_run(pcr);
> -
> -       rtsx_pci_switch_clock(host->pcr, host->clock, host->ssc_depth,
> -                       false, true, false);
> -       rtsx_pci_write_register(pcr, CARD_SELECT, 0x07, MS_MOD_SEL);
> -       rtsx_pci_write_register(pcr, CARD_SHARE_MODE,
> -                       CARD_SHARE_MASK, CARD_SHARE_48_MS);
> -
> -       if (!host->req) {
> -               do {
> -                       rc = memstick_next_req(msh, &host->req);
> -                       dev_dbg(ms_dev(host), "next req %d\n", rc);
> -
> -                       if (!rc)
> -                               host->req->error = rtsx_pci_ms_issue_cmd(host);
> -               } while (!rc);
> -       }
> -
> -       mutex_unlock(&pcr->pcr_mutex);
> -}
> -
> -static void rtsx_pci_ms_request(struct memstick_host *msh)
> -{
> -       struct realtek_pci_ms *host = memstick_priv(msh);
> -
> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
> -
> -       if (rtsx_pci_card_exclusive_check(host->pcr, RTSX_MS_CARD))
> -               return;
> -
> -       schedule_work(&host->handle_req);
> -}
> -
> -static int rtsx_pci_ms_set_param(struct memstick_host *msh,
> -               enum memstick_param param, int value)
> -{
> -       struct realtek_pci_ms *host = memstick_priv(msh);
> -       struct rtsx_pcr *pcr = host->pcr;
> -       unsigned int clock = 0;
> -       u8 ssc_depth = 0;
> -       int err;
> -
> -       dev_dbg(ms_dev(host), "%s: param = %d, value = %d\n",
> -                       __func__, param, value);
> -
> -       err = rtsx_pci_card_exclusive_check(host->pcr, RTSX_MS_CARD);
> -       if (err)
> -               return err;
> -
> -       switch (param) {
> -       case MEMSTICK_POWER:
> -               if (value == MEMSTICK_POWER_ON)
> -                       err = ms_power_on(host);
> -               else if (value == MEMSTICK_POWER_OFF)
> -                       err = ms_power_off(host);
> -               else
> -                       return -EINVAL;
> -               break;
> -
> -       case MEMSTICK_INTERFACE:
> -               if (value == MEMSTICK_SERIAL) {
> -                       clock = 19000000;
> -                       ssc_depth = RTSX_SSC_DEPTH_500K;
> -
> -                       err = rtsx_pci_write_register(pcr, MS_CFG, 0x58,
> -                                       MS_BUS_WIDTH_1 | PUSH_TIME_DEFAULT);
> -                       if (err < 0)
> -                               return err;
> -               } else if (value == MEMSTICK_PAR4) {
> -                       clock = 39000000;
> -                       ssc_depth = RTSX_SSC_DEPTH_1M;
> -
> -                       err = rtsx_pci_write_register(pcr, MS_CFG,
> -                                       0x58, MS_BUS_WIDTH_4 | PUSH_TIME_ODD);
> -                       if (err < 0)
> -                               return err;
> -               } else {
> -                       return -EINVAL;
> -               }
> -
> -               err = rtsx_pci_switch_clock(pcr, clock,
> -                               ssc_depth, false, true, false);
> -               if (err < 0)
> -                       return err;
> -
> -               host->ssc_depth = ssc_depth;
> -               host->clock = clock;
> -               host->ifmode = value;
> -               break;
> -       }
> -
> -       return 0;
> -}
> -
> -#ifdef CONFIG_PM
> -
> -static int rtsx_pci_ms_suspend(struct platform_device *pdev, pm_message_t state)
> -{
> -       struct realtek_pci_ms *host = platform_get_drvdata(pdev);
> -       struct memstick_host *msh = host->msh;
> -
> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
> -
> -       memstick_suspend_host(msh);
> -       return 0;
> -}
> -
> -static int rtsx_pci_ms_resume(struct platform_device *pdev)
> -{
> -       struct realtek_pci_ms *host = platform_get_drvdata(pdev);
> -       struct memstick_host *msh = host->msh;
> -
> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
> -
> -       memstick_resume_host(msh);
> -       return 0;
> -}
> -
> -#else /* CONFIG_PM */
> -
> -#define rtsx_pci_ms_suspend NULL
> -#define rtsx_pci_ms_resume NULL
> -
> -#endif /* CONFIG_PM */
> -
> -static void rtsx_pci_ms_card_event(struct platform_device *pdev)
> -{
> -       struct realtek_pci_ms *host = platform_get_drvdata(pdev);
> -
> -       memstick_detect_change(host->msh);
> -}
> -
> -static int rtsx_pci_ms_drv_probe(struct platform_device *pdev)
> -{
> -       struct memstick_host *msh;
> -       struct realtek_pci_ms *host;
> -       struct rtsx_pcr *pcr;
> -       struct pcr_handle *handle = pdev->dev.platform_data;
> -       int rc;
> -
> -       if (!handle)
> -               return -ENXIO;
> -
> -       pcr = handle->pcr;
> -       if (!pcr)
> -               return -ENXIO;
> -
> -       dev_dbg(&(pdev->dev),
> -                       ": Realtek PCI-E Memstick controller found\n");
> -
> -       msh = memstick_alloc_host(sizeof(*host), &pdev->dev);
> -       if (!msh)
> -               return -ENOMEM;
> -
> -       host = memstick_priv(msh);
> -       host->pcr = pcr;
> -       host->msh = msh;
> -       host->pdev = pdev;
> -       platform_set_drvdata(pdev, host);
> -       pcr->slots[RTSX_MS_CARD].p_dev = pdev;
> -       pcr->slots[RTSX_MS_CARD].card_event = rtsx_pci_ms_card_event;
> -
> -       mutex_init(&host->host_mutex);
> -
> -       INIT_WORK(&host->handle_req, rtsx_pci_ms_handle_req);
> -       msh->request = rtsx_pci_ms_request;
> -       msh->set_param = rtsx_pci_ms_set_param;
> -       msh->caps = MEMSTICK_CAP_PAR4;
> -
> -       rc = memstick_add_host(msh);
> -       if (rc) {
> -               memstick_free_host(msh);
> -               return rc;
> -       }
> -
> -       return 0;
> -}
> -
> -static void rtsx_pci_ms_drv_remove(struct platform_device *pdev)
> -{
> -       struct realtek_pci_ms *host = platform_get_drvdata(pdev);
> -       struct rtsx_pcr *pcr;
> -       struct memstick_host *msh;
> -       int rc;
> -
> -       pcr = host->pcr;
> -       pcr->slots[RTSX_MS_CARD].p_dev = NULL;
> -       pcr->slots[RTSX_MS_CARD].card_event = NULL;
> -       msh = host->msh;
> -       host->eject = true;
> -       cancel_work_sync(&host->handle_req);
> -
> -       mutex_lock(&host->host_mutex);
> -       if (host->req) {
> -               dev_dbg(&(pdev->dev),
> -                       "%s: Controller removed during transfer\n",
> -                       dev_name(&msh->dev));
> -
> -               rtsx_pci_complete_unfinished_transfer(pcr);
> -
> -               host->req->error = -ENOMEDIUM;
> -               do {
> -                       rc = memstick_next_req(msh, &host->req);
> -                       if (!rc)
> -                               host->req->error = -ENOMEDIUM;
> -               } while (!rc);
> -       }
> -       mutex_unlock(&host->host_mutex);
> -
> -       memstick_remove_host(msh);
> -       memstick_free_host(msh);
> -
> -       dev_dbg(&(pdev->dev),
> -               ": Realtek PCI-E Memstick controller has been removed\n");
> -}
> -
> -static struct platform_device_id rtsx_pci_ms_ids[] = {
> -       {
> -               .name = DRV_NAME_RTSX_PCI_MS,
> -       }, {
> -               /* sentinel */
> -       }
> -};
> -MODULE_DEVICE_TABLE(platform, rtsx_pci_ms_ids);
> -
> -static struct platform_driver rtsx_pci_ms_driver = {
> -       .probe          = rtsx_pci_ms_drv_probe,
> -       .remove_new     = rtsx_pci_ms_drv_remove,
> -       .id_table       = rtsx_pci_ms_ids,
> -       .suspend        = rtsx_pci_ms_suspend,
> -       .resume         = rtsx_pci_ms_resume,
> -       .driver         = {
> -               .name   = DRV_NAME_RTSX_PCI_MS,
> -       },
> -};
> -module_platform_driver(rtsx_pci_ms_driver);
> -
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Wei WANG <wei_wang@realsil.com.cn>");
> -MODULE_DESCRIPTION("Realtek PCI-E Memstick Card Host Driver");
> --
> 2.43.0
>

