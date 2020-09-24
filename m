Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69C5277183
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Sep 2020 14:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgIXMuP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 24 Sep 2020 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbgIXMuG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 08:50:06 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA63C0613CE
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:06 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id q124so860451vkb.8
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnddfcAzp662iEl9KigyhAvJGdoz9QK4/ZZLC6F3MuI=;
        b=xlZQMRY/W4OFxyVddObGTDk8bcDCpTmP1fowScD0Jvkc7oKkv8FhAQeWy84N0ZhaaY
         l0MEjrvF7f37MKPhcwIXhYAEmGqug8Nw60tauSSIH2yxOmM1/FBKpVEIwV6Rkjb20072
         ZwEIHztTW/h7JqoMbwMlh/YI9WMDKUlMb2YI2Kl3lhT8iPudIz1unzhSjuqLc++YqdKZ
         OBiNYVbbuahv8M38nQk22HELN0PKptaVM1193XDg//gXbEj+E6zuc7xitgEOmMpf/RV6
         IDHCrQjbK+0hJKj647yLJZL4Obq/DPhiiIw+PB45RPCELHQGYBD1heQXwnJA4y3Y+ay7
         U2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnddfcAzp662iEl9KigyhAvJGdoz9QK4/ZZLC6F3MuI=;
        b=BXEoYPylFflYR0bMhkeDYzYreuCuiZuLNuPogXDlA5p2Zl7beXn3a5rbzlFpxXG3PB
         RwhP+0YOSA/vDok7DXRvOld5nYQHvN2CR4/QpSSicGn8Iy/aU4l4MBvC2sBnP02Akbwg
         bmIFZSLlF2K52JQfFF68jUUvdJkTjmgi31+uCd1Aw/YWt/4ofg/wUhMDdtaboTqaoeP0
         w7Xm/THKTQW5nV6OdedDO0vtwVf6TqMKUY9/euzALfCqt83p9PzVfrQQOjnkK+zjRH40
         pS7MGlbubX+u/W854DT5pjK8qcRElJ1+VgE/XiQvGd6/uypOEcMO6QSU2NBjfnfrIDhg
         +PSg==
X-Gm-Message-State: AOAM532cJjpX448edXiin9zcrBJDSns9p6ULU1Vsy1qMocgJJY78Qjl/
        Mq9Bvmg2Knjv8zmdYWKqkIxpME2ElyQ97/15esFG3Q==
X-Google-Smtp-Source: ABdhPJweLqRrdU4UiHF3cqaQwdwaRlMidr3x1EIzZx4rQiO8mqdv36WK/R/dBPN87yGM7Plfjouym0SxRYLsTorW5Ik=
X-Received: by 2002:ac5:cced:: with SMTP id k13mr3485134vkn.7.1600951805106;
 Thu, 24 Sep 2020 05:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200917192624.548720-1-ameynarkhede03@gmail.com>
In-Reply-To: <20200917192624.548720-1-ameynarkhede03@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:27 +0200
Message-ID: <CAPDyKFoJYGMcjykaBLy3uwWws87cp2Fc9xYBqe+9bcK8S4q9Ug@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: Drop pointer to mmc_host from msdc_host
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Sep 2020 at 21:27, Amey Narkhede <ameynarkhede03@gmail.com> wrote:
>
> The MediaTek MMC driver uses  pointer to get from private
> msdc_host structure to the generic mmc_host structure.
> However mmc_host always precedes msdc_host in memory so compute
> its address with a subtraction (which is cheaper than a dereference)
> using mmc_from_priv() and drop the extra pointer.
>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 45 ++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b0c27944db7f..bbd9064e3e4a 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -397,7 +397,6 @@ struct msdc_delay_phase {
>  struct msdc_host {
>         struct device *dev;
>         const struct mtk_mmc_compatible *dev_comp;
> -       struct mmc_host *mmc;   /* mmc structure */
>         int cmd_rsp;
>
>         spinlock_t lock;
> @@ -734,14 +733,15 @@ static void msdc_unprepare_data(struct msdc_host *host, struct mmc_request *mrq)
>
>  static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
>  {
> +       struct mmc_host *mmc = mmc_from_priv(host);
>         u64 timeout, clk_ns;
>         u32 mode = 0;
>
> -       if (host->mmc->actual_clock == 0) {
> +       if (mmc->actual_clock == 0) {
>                 timeout = 0;
>         } else {
>                 clk_ns  = 1000000000ULL;
> -               do_div(clk_ns, host->mmc->actual_clock);
> +               do_div(clk_ns, mmc->actual_clock);
>                 timeout = ns + clk_ns - 1;
>                 do_div(timeout, clk_ns);
>                 timeout += clks;
> @@ -802,6 +802,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
>
>  static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>  {
> +       struct mmc_host *mmc = mmc_from_priv(host);
>         u32 mode;
>         u32 flags;
>         u32 div;
> @@ -811,7 +812,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>         if (!hz) {
>                 dev_dbg(host->dev, "set mclk to 0\n");
>                 host->mclk = 0;
> -               host->mmc->actual_clock = 0;
> +               mmc->actual_clock = 0;
>                 sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
>                 return;
>         }
> @@ -890,7 +891,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
>         sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
> -       host->mmc->actual_clock = sclk;
> +       mmc->actual_clock = sclk;
>         host->mclk = hz;
>         host->timing = timing;
>         /* need because clk changed. */
> @@ -901,7 +902,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>          * mmc_select_hs400() will drop to 50Mhz and High speed mode,
>          * tune result of hs200/200Mhz is not suitable for 50Mhz
>          */
> -       if (host->mmc->actual_clock <= 52000000) {
> +       if (mmc->actual_clock <= 52000000) {
>                 writel(host->def_tune_para.iocon, host->base + MSDC_IOCON);
>                 if (host->top_base) {
>                         writel(host->def_tune_para.emmc_top_control,
> @@ -932,7 +933,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>                 sdr_set_field(host->base + tune_reg,
>                               MSDC_PAD_TUNE_CMDRRDLY,
>                               host->hs400_cmd_int_delay);
> -       dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->mmc->actual_clock,
> +       dev_dbg(host->dev, "sclk: %d, timing: %d\n", mmc->actual_clock,
>                 timing);
>  }
>
> @@ -967,6 +968,7 @@ static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
>  static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd)
>  {
> +       struct mmc_host *mmc = mmc_from_priv(host);
>         /* rawcmd :
>          * vol_swt << 30 | auto_cmd << 28 | blklen << 16 | go_irq << 15 |
>          * stop << 14 | rw << 13 | dtype << 11 | rsptyp << 7 | brk << 6 | opcode
> @@ -993,7 +995,7 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
>                 struct mmc_data *data = cmd->data;
>
>                 if (mmc_op_multi(opcode)) {
> -                       if (mmc_card_mmc(host->mmc->card) && mrq->sbc &&
> +                       if (mmc_card_mmc(mmc->card) && mrq->sbc &&
>                             !(mrq->sbc->arg & 0xFFFF0000))
>                                 rawcmd |= 0x2 << 28; /* AutoCMD23 */
>                 }
> @@ -1070,9 +1072,10 @@ static int msdc_auto_cmd_done(struct msdc_host *host, int events,
>   */
>  static void msdc_recheck_sdio_irq(struct msdc_host *host)
>  {
> +       struct mmc_host *mmc = mmc_from_priv(host);
>         u32 reg_int, reg_inten, reg_ps;
>
> -       if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
> +       if (mmc->caps & MMC_CAP_SDIO_IRQ) {
>                 reg_inten = readl(host->base + MSDC_INTEN);
>                 if (reg_inten & MSDC_INTEN_SDIOIRQ) {
>                         reg_int = readl(host->base + MSDC_INT);
> @@ -1080,7 +1083,7 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
>                         if (!(reg_int & MSDC_INT_SDIOIRQ ||
>                               reg_ps & MSDC_PS_DATA1)) {
>                                 __msdc_enable_sdio_irq(host, 0);
> -                               sdio_signal_irq(host->mmc);
> +                               sdio_signal_irq(mmc);
>                         }
>                 }
>         }
> @@ -1113,7 +1116,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>                 msdc_unprepare_data(host, mrq);
>         if (host->error)
>                 msdc_reset_hw(host);
> -       mmc_request_done(host->mmc, mrq);
> +       mmc_request_done(mmc_from_priv(host), mrq);
>         if (host->dev_comp->recheck_sdio_irq)
>                 msdc_recheck_sdio_irq(host);
>  }
> @@ -1500,6 +1503,7 @@ static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
>
>  static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
>  {
> +       struct mmc_host *mmc = mmc_from_priv(host);
>         int cmd_err = 0, dat_err = 0;
>
>         if (intsts & MSDC_INT_RSPCRCERR) {
> @@ -1523,12 +1527,13 @@ static irqreturn_t msdc_cmdq_irq(struct msdc_host *host, u32 intsts)
>                         cmd_err, dat_err, intsts);
>         }
>
> -       return cqhci_irq(host->mmc, 0, cmd_err, dat_err);
> +       return cqhci_irq(mmc, 0, cmd_err, dat_err);
>  }
>
>  static irqreturn_t msdc_irq(int irq, void *dev_id)
>  {
>         struct msdc_host *host = (struct msdc_host *) dev_id;
> +       struct mmc_host *mmc = mmc_from_priv(host);
>
>         while (true) {
>                 unsigned long flags;
> @@ -1551,18 +1556,18 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 spin_unlock_irqrestore(&host->lock, flags);
>
>                 if ((events & event_mask) & MSDC_INT_SDIOIRQ)
> -                       sdio_signal_irq(host->mmc);
> +                       sdio_signal_irq(mmc);
>
>                 if ((events & event_mask) & MSDC_INT_CDSC) {
>                         if (host->internal_cd)
> -                               mmc_detect_change(host->mmc, msecs_to_jiffies(20));
> +                               mmc_detect_change(mmc, msecs_to_jiffies(20));
>                         events &= ~MSDC_INT_CDSC;
>                 }
>
>                 if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
>                         break;
>
> -               if ((host->mmc->caps2 & MMC_CAP2_CQE) &&
> +               if ((mmc->caps2 & MMC_CAP2_CQE) &&
>                     (events & MSDC_INT_CMDQ)) {
>                         msdc_cmdq_irq(host, events);
>                         /* clear interrupts */
> @@ -2434,7 +2439,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
>
>         host->dev = &pdev->dev;
>         host->dev_comp = of_device_get_match_data(&pdev->dev);
> -       host->mmc = mmc;
>         host->src_clk_freq = clk_get_rate(host->src_clk);
>         /* Set host parameters to mmc */
>         mmc->ops = &mt_msdc_ops;
> @@ -2475,7 +2479,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         mmc_dev(mmc)->dma_mask = &host->dma_mask;
>
>         if (mmc->caps2 & MMC_CAP2_CQE) {
> -               host->cq_host = devm_kzalloc(host->mmc->parent,
> +               host->cq_host = devm_kzalloc(mmc->parent,
>                                              sizeof(*host->cq_host),
>                                              GFP_KERNEL);
>                 if (!host->cq_host) {
> @@ -2560,7 +2564,7 @@ static int msdc_drv_remove(struct platform_device *pdev)
>         pm_runtime_get_sync(host->dev);
>
>         platform_set_drvdata(pdev, NULL);
> -       mmc_remove_host(host->mmc);
> +       mmc_remove_host(mmc);
>         msdc_deinit_hw(host);
>         msdc_gate_clock(host);
>
> @@ -2572,7 +2576,7 @@ static int msdc_drv_remove(struct platform_device *pdev)
>         dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
>                         host->dma.bd, host->dma.bd_addr);
>
> -       mmc_free_host(host->mmc);
> +       mmc_free_host(mmc);
>
>         return 0;
>  }
> @@ -2607,6 +2611,7 @@ static void msdc_save_reg(struct msdc_host *host)
>
>  static void msdc_restore_reg(struct msdc_host *host)
>  {
> +       struct mmc_host *mmc = mmc_from_priv(host);
>         u32 tune_reg = host->dev_comp->pad_tune_reg;
>
>         writel(host->save_para.msdc_cfg, host->base + MSDC_CFG);
> @@ -2631,7 +2636,7 @@ static void msdc_restore_reg(struct msdc_host *host)
>                 writel(host->save_para.pad_tune, host->base + tune_reg);
>         }
>
> -       if (sdio_irq_claimed(host->mmc))
> +       if (sdio_irq_claimed(mmc))
>                 __msdc_enable_sdio_irq(host, 1);
>  }
>
> --
> 2.28.0
