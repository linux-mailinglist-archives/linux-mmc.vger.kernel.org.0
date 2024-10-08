Return-Path: <linux-mmc+bounces-4255-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F149951EF
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Oct 2024 16:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406671C246BB
	for <lists+linux-mmc@lfdr.de>; Tue,  8 Oct 2024 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC461E04A8;
	Tue,  8 Oct 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlIzVXj9"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E621E04B8
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398201; cv=none; b=nvww6AqatI3tCGnag+kUzvKW4q3aLjagF2RxoMyKvV7dxSHjgJsYmsQOBMC5xPVkEhShHWnedAFHuny2wur17YERZ7btdqR9C1tqFHgRGHb6F1d7LzDZssY2HlvSY5VJtHPd2KrQmfhZmsP+VAO8LY7OAYBVaDdD6xAdixFsf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398201; c=relaxed/simple;
	bh=DpUenX+Bc2RPNyjVe8nYHQm3E0I2Ojx6oLl64ovzirY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUonAuurGrouWfIIrYjjiizHFO222+C8QzX/P2ZmsNRV6kbaS4hTJ/F7ZHScCzMyiVPQRtzL9Ymv3T/C1c5SZkd8y5OCrW+PVoX+62n91q81QVxHjL+3qRxBfWXSyR1S8cbL6cxA3QU1KWQSxCgqL2zSXeOpcGiHMEnkl7p0XLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlIzVXj9; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e25d6342837so4886178276.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398198; x=1729002998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nRoELk3rhVviZWh04GOx6h6H0EVODk7FRINx2V/LU5E=;
        b=ZlIzVXj9bhEgT0W8anGGYe0cJ3T6uXBu/UATxd+ZQOyB02rH/NzX1yRHcSqA1Bs/Iw
         esI22pjfMjn83nkt43fPV9Ll6C75GwXB/TC4BpKi1cHWxhzQ/PZkPYvdm/3CE9qlvv54
         eRdtSx9Za2BDH4l2eeTnQ6cygOgWUkOU4rj4k1CYL01djQIUdtuXXdW5ng3z/rWepz5B
         aDDgmb0yRnOYVYb5dVeYu+OmbAoMDMp0kwWFDqqTRcHWefPRX+Bf3vKnG0mGErfhxYSi
         UAhoRV5Ez1xX/jTtrXUGbZwq01XYEje4sZyfAr/SUcB4cQhe1yPHYUAAC90ZKVX9PRQd
         X3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398198; x=1729002998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRoELk3rhVviZWh04GOx6h6H0EVODk7FRINx2V/LU5E=;
        b=lQg3t6uEv5Bc8bbjJpmlCuSUqYqpmZfTYGJJ91vRrmfs02+Dgw7NQf9IhvXEXJRnqb
         aV8/vLMJbnVlywVgfRpbOr7Kwh3q6HGYWA4WW/NO2FrmAw0EWcu3UvMx8kPZaSDK9du9
         mEm6wK5gGNF0qCS3xfbLCj87dqj3/93ULZh6v+jyu/RuMpfcYM3NB+9/2I4YIN9g2bjn
         KT7N3rarY5/ZBtJK1OIekJ6GCZDSwAl+T4yLQ4REIYmBk8LHO0t++u2VErWSD36zMhuN
         fs17IZewK4UPlUJkkQLuUW2LA7rGMe95og/KnzcpifqakWdKlu1owominxkr2hMKNi/p
         q6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVKTqzgn0VsMzQ2AEKEamfe9ziRIr3YqHAM9lNm7aw4JtlDJzA8PeDtwcGFSOG9IvJBsQz2UERzUtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0n7HpC4k/3UjC7jSkcfJcdZ2M9pjSi6vCJGmrltv1rh3GhMP
	PU5Y+qxiopDBFHAXbPftmgu9wa820IssINtpoREegjRMkuLjnGdHBt7D4roSmbCMFw4SDzDWhig
	6OsTGk4D0d8BHIV4Cb5HE22AN6SOhZYtNAB3jrw==
X-Google-Smtp-Source: AGHT+IFOx/T4JRktigNljdOZeGzepgmrQfoMq1MLWhEjsp0XXjH7H84Niy2QxiDxNQ3SjuMrTLx1lkRM5mMt6rQFZBE=
X-Received: by 2002:a05:6902:1102:b0:e28:f31f:5f72 with SMTP id
 3f1490d57ef6-e28f31f6125mr1345325276.19.1728398198478; Tue, 08 Oct 2024
 07:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930090156.33537-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240930090156.33537-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:35:57 +0200
Message-ID: <CAPDyKFpwmnm4iSrdKW5H2Xz26W=LFLFEYQKfLCoJ5e79a09H_Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: Implement Host Software Queue for eMMC
 and SD Card
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Sept 2024 at 11:01, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add support for Host Software Queue (HSQ) and enable it when the
> controller instance does not have Command Queue Engine HW support.
>
> It was chosen to enable HSQ only for eMMC and SD/MicroSD cards
> and not for SDIO as performance improvements are seen only for
> the former.
>
> Performance was measured with a SanDisk Extreme Ultra A2 MicroSD
> card in a MediaTek MT8195T Acer Chromebook Spin 513 (CP513-2H),
> by running FIO (bs=4k) on an ArchLinux userspace.
>
> .... Summarizing ....
> Random read:     +24.28% IOPS, +24.29% BW
> Sequential read: +3.14%  IOPS, +3.49%  BW
> Random RW (avg): +50.53% IOPS, +50.68% BW
>
> Below, more data from the benchmarks.
>
> Before:
>  - Random read: IOPS=1643, BW=6574KiB/s
>    bw (  KiB/s): min= 4578, max= 7440, per=99.95%, avg=6571.55, stdev=74.16, samples=953
>    iops        : min= 1144, max= 1860, avg=1642.14, stdev=18.54, samples=953
>    lat (msec)  : 100=0.01%, 250=0.12%, 500=0.38%, 750=97.89%, 1000=1.44%, 2000=0.16%
>  - Sequential read: IOPS=19.1k, BW=74.4MiB/s
>    bw (  KiB/s): min=12288, max=118483, per=100.00%, avg=76293.38, stdev=1971.42, samples=956
>    iops        : min= 3072, max=29620, avg=19072.14, stdev=492.87, samples=956
>    lat (msec)  : 4=0.01%, 10=0.01%, 20=0.21%, 50=23.95%, 100=75.67%, 250=0.05%, 500=0.03%, 750=0.08%
>  - Random R/W: read: IOPS=282, BW=1129KiB/s (1156kB/s)  write: IOPS=284, BW=1136KiB/s
>    read bw (  KiB/s): min=   31, max= 3496, per=100.00%, avg=1703.67, stdev=155.42, samples=630
>    read iops        : min=    7, max=  873, avg=425.22, stdev=38.85, samples=630
>    wri  bw (  KiB/s): min=   31, max= 3443, per=100.00%, avg=1674.27, stdev=164.23, samples=644
>    wri  iops        : min=    7, max=  860, avg=417.87, stdev=41.03, samples=644
>    lat (msec)   : 250=0.13%, 500=0.44%, 750=0.84%, 1000=22.29%, 2000=74.01%, >=2000=2.30%
>
> After:
>  - Random read: IOPS=2042, BW=8171KiB/s
>    bw (  KiB/s): min= 4907, max= 9072, per=99.94%, avg=8166.80, stdev=93.77, samples=954
>    iops        : min= 1226, max= 2268, avg=2040.78, stdev=23.41, samples=954
>    lat (msec)   : 100=0.03%, 250=0.13%, 500=52.88%, 750=46.64%, 1000=0.32%
>  - Sequential read: IOPS=19.7k, BW=77.0MiB/s
>    bw (  KiB/s): min=67980, max=94248, per=100.00%, avg=78894.27, stdev=1475.07, samples=956
>    iops        : min=16994, max=23562, avg=19722.45, stdev=368.76, samples=956
>    lat (msec)   : 4=0.01%, 10=0.01%, 20=0.05%, 50=28.78%, 100=71.14%, 250=0.01%, 500=0.02%
>  - Random R/W: read: IOPS=424, BW=1699KiB/s  write: IOPS=428, BW=1714KiB/s
>    read bw (  KiB/s): min=  228, max= 2856, per=100.00%, avg=1796.60, stdev=112.59, samples=901
>    read iops        : min=   54, max=  712, avg=447.81, stdev=28.21, samples=901
>    wri  bw (  KiB/s): min=   28, max= 2904, per=100.00%, avg=1780.11, stdev=128.27, samples=916
>    wri  iops        : min=    4, max=  724, avg=443.69, stdev=32.14, samples=916
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v2:
>  - Added missing `select MMC_HSQ` for MMC_MTK Kconfig
>
>  drivers/mmc/host/Kconfig  |  1 +
>  drivers/mmc/host/mtk-sd.c | 49 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7199cb0bd0b9..0ba5a9f769fb 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1009,6 +1009,7 @@ config MMC_MTK
>         depends on COMMON_CLK
>         select REGULATOR
>         select MMC_CQHCI
> +       select MMC_HSQ
>         help
>           This selects the MediaTek(R) Secure digital and Multimedia card Interface.
>           If you have a machine with a integrated SD/MMC card reader, say Y or M here.
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 5165a33bf74b..a9a554bd3f44 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -33,6 +33,7 @@
>  #include <linux/mmc/slot-gpio.h>
>
>  #include "cqhci.h"
> +#include "mmc_hsq.h"
>
>  #define MAX_BD_NUM          1024
>  #define MSDC_NR_CLOCKS      3
> @@ -473,6 +474,7 @@ struct msdc_host {
>         bool hs400_tuning;      /* hs400 mode online tuning */
>         bool internal_cd;       /* Use internal card-detect logic */
>         bool cqhci;             /* support eMMC hw cmdq */
> +       bool hsq_en;            /* Host Software Queue is enabled */
>         struct msdc_save_para save_para; /* used when gate HCLK */
>         struct msdc_tune_para def_tune_para; /* default tune setting */
>         struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
> @@ -1170,7 +1172,9 @@ static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
>
>  static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>  {
> +       struct mmc_host *mmc = mmc_from_priv(host);
>         unsigned long flags;
> +       bool hsq_req_done;
>
>         /*
>          * No need check the return value of cancel_delayed_work, as only ONE
> @@ -1178,6 +1182,27 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>          */
>         cancel_delayed_work(&host->req_timeout);
>
> +       /*
> +        * If the request was handled from Host Software Queue, there's almost
> +        * nothing to do here, and we also don't need to reset mrq as any race
> +        * condition would not have any room to happen, since HSQ stores the
> +        * "scheduled" mrqs in an internal array of mrq slots anyway.
> +        * However, if the controller experienced an error, we still want to
> +        * reset it as soon as possible.
> +        *
> +        * Note that non-HSQ requests will still be happening at times, even
> +        * though it is enabled, and that's what is going to reset host->mrq.
> +        * Also, msdc_unprepare_data() is going to be called by HSQ when needed
> +        * as HSQ request finalization will eventually call the .post_req()
> +        * callback of this driver which, in turn, unprepares the data.
> +        */
> +       hsq_req_done = host->hsq_en ? mmc_hsq_finalize_request(mmc, mrq) : false;
> +       if (hsq_req_done) {
> +               if (host->error)
> +                       msdc_reset_hw(host);
> +               return;
> +       }
> +
>         spin_lock_irqsave(&host->lock, flags);
>         host->mrq = NULL;
>         spin_unlock_irqrestore(&host->lock, flags);
> @@ -1187,7 +1212,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>                 msdc_unprepare_data(host, mrq->data);
>         if (host->error)
>                 msdc_reset_hw(host);
> -       mmc_request_done(mmc_from_priv(host), mrq);
> +       mmc_request_done(mmc, mrq);
>         if (host->dev_comp->recheck_sdio_irq)
>                 msdc_recheck_sdio_irq(host);
>  }
> @@ -1347,7 +1372,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         struct msdc_host *host = mmc_priv(mmc);
>
>         host->error = 0;
> -       WARN_ON(host->mrq);
> +       WARN_ON(!host->hsq_en && host->mrq);
>         host->mrq = mrq;
>
>         if (mrq->data)
> @@ -2916,6 +2941,19 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 mmc->max_seg_size = 64 * 1024;
>                 /* Reduce CIT to 0x40 that corresponds to 2.35us */
>                 msdc_cqe_cit_cal(host, 2350);
> +       } else if (mmc->caps2 & MMC_CAP2_NO_SDIO) {
> +               /* Use HSQ on eMMC/SD (but not on SDIO) if HW CQE not supported */
> +               struct mmc_hsq *hsq = devm_kzalloc(&pdev->dev, sizeof(*hsq), GFP_KERNEL);
> +               if (!hsq) {
> +                       ret = -ENOMEM;
> +                       goto release;
> +               }
> +
> +               ret = mmc_hsq_init(hsq, mmc);
> +               if (ret)
> +                       goto release;
> +
> +               host->hsq_en = true;
>         }
>
>         ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> @@ -3043,6 +3081,9 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct msdc_host *host = mmc_priv(mmc);
>
> +       if (host->hsq_en)
> +               mmc_hsq_suspend(mmc);
> +
>         msdc_save_reg(host);
>
>         if (sdio_irq_claimed(mmc)) {
> @@ -3073,6 +3114,10 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>                 pinctrl_select_state(host->pinctrl, host->pins_uhs);
>                 enable_irq(host->irq);
>         }
> +
> +       if (host->hsq_en)
> +               mmc_hsq_resume(mmc);
> +
>         return 0;
>  }
>
> --
> 2.46.1
>

