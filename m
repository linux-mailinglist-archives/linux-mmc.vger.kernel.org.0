Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C349559EC48
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Aug 2022 21:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiHWT3L (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Aug 2022 15:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiHWT25 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2022 15:28:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF7104454
        for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2022 11:17:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w20so3338401edd.10
        for <linux-mmc@vger.kernel.org>; Tue, 23 Aug 2022 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=m0AKNxjraePJbgc0kbw7i1yv4eHM9KSiHBpngL9FYGw=;
        b=C7MXIu22v6ydd067VMcWHPyXRgBYJYi0aHm4zi9YY8QMlpgeIxV1n+ashWvbu6K0j5
         95NX++1vmdHAv0BZicBBPGKQoB/2jjrnYb6TAz//xtbkish/nC/XE3zB26FFjagm58ch
         Iq90+/D4y8MmHRmzvTfEMetP0X672pCGLecOjhu/B+uaOvjXsL+Fb64h7vT67MZWcQBp
         s4QeRaSFeXSXTRWOh43rc1wlbQI0lEXEVFJfIO/raC7Y2BT8RLLz9Rgu6EEICqesJH75
         EClKsSAzhg5gW4zOCzKvZIHZwTP/o2VPUJXsXnCExToYg+n8SYxdFhvpuZYJCwyZIoZD
         OqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=m0AKNxjraePJbgc0kbw7i1yv4eHM9KSiHBpngL9FYGw=;
        b=3C7/EvkvBtJELn4n+tEkLkX7To5r015VfPWA5f2VV9O5vV0sEPx2IiV64OCe+LvL0C
         brJujBOHSONz38J/fyrykKrlEV7BeqvxJgyrrbiVk+GzNJGXNbOGctFiADeMfp1DkTzU
         hdSdwNiksWzZsmAii5pLNJqNYaQA/e44uAvuAb6mZYrY5t06Ku361GKjeqSydhcs1NvQ
         q6Kjs0znSj4Tu7KkQUponbF8Nvu4ARvdeLJp8IvMyWWkFvgCYvfWJ814IMdW1BAvmI+6
         2SFkjfXoWrXAd2nnb8PCedCu0D553HnIoe2o/l3vma8qyYXmoXyzepX1Ik+Kv4IgEFV6
         4Sbw==
X-Gm-Message-State: ACgBeo3PtWIqoF3brhirg7uiePbhNpA07Kx+gryo+ceYoNI90tnEe8t+
        xbVgOxem8kPso2sTQwhnLflweeYX5NU=
X-Google-Smtp-Source: AA6agR7j9blmJ1pYdX2qbLGajNRC0fnG83KAfEHehUjuMBJVKcOtQjmXE70N/UdVYbEZ12WTn3a+9A==
X-Received: by 2002:a05:6402:4496:b0:446:9708:5e12 with SMTP id er22-20020a056402449600b0044697085e12mr4557193edb.165.1661278616034;
        Tue, 23 Aug 2022 11:16:56 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7758:1500:8528:d099:20f2:8fd6? (dynamic-2a01-0c22-7758-1500-8528-d099-20f2-8fd6.c22.pool.telefonica.de. [2a01:c22:7758:1500:8528:d099:20f2:8fd6])
        by smtp.googlemail.com with ESMTPSA id ca21-20020aa7cd75000000b004460b020ffdsm1773188edb.83.2022.08.23.11.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 11:16:55 -0700 (PDT)
Message-ID: <8e827905-f318-4711-a995-80b59e296939@gmail.com>
Date:   Tue, 23 Aug 2022 20:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <b94b7f5b-1095-33a5-b1a0-20a6e2281bce@gmail.com>
 <a185b4e9-f238-c2e6-0847-79cd8265844a@gmail.com>
 <CAPDyKFopddPSU-cSdnfXGbg91zNWWEX5L9kvMmtVrvxumD0R3w@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: meson-gx: add SDIO interrupt support
In-Reply-To: <CAPDyKFopddPSU-cSdnfXGbg91zNWWEX5L9kvMmtVrvxumD0R3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22.08.2022 13:33, Ulf Hansson wrote:
> On Fri, 19 Aug 2022 at 23:14, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Add SDIO interrupt support. Successfully tested on a S905X4-based
>> system (V3 register layout) with a BRCM4334 SDIO wifi module
>> (brcmfmac driver). The implementation also considers the potential
>> race discussed in [0].
>>
>> [0] https://lore.kernel.org/linux-arm-kernel/CAPDyKFoJDhjLkajBHgW3zHasvYYri77NQoDpiW-BpKgkdjtOyg@mail.gmail.com/
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 76 ++++++++++++++++++++++++++++-----
>>  1 file changed, 66 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 9a4da2544..58b7836a5 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -41,14 +41,17 @@
>>  #define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
>>  #define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
>>  #define   CLK_V2_ALWAYS_ON BIT(24)
>> +#define   CLK_V2_IRQ_SDIO_SLEEP BIT(25)
>>
>>  #define   CLK_V3_TX_DELAY_MASK GENMASK(21, 16)
>>  #define   CLK_V3_RX_DELAY_MASK GENMASK(27, 22)
>>  #define   CLK_V3_ALWAYS_ON BIT(28)
>> +#define   CLK_V3_IRQ_SDIO_SLEEP BIT(29)
>>
>>  #define   CLK_TX_DELAY_MASK(h)         (h->data->tx_delay_mask)
>>  #define   CLK_RX_DELAY_MASK(h)         (h->data->rx_delay_mask)
>>  #define   CLK_ALWAYS_ON(h)             (h->data->always_on)
>> +#define   CLK_IRQ_SDIO_SLEEP(h)                (h->data->irq_sdio_sleep)
>>
>>  #define SD_EMMC_DELAY 0x4
>>  #define SD_EMMC_ADJUST 0x8
>> @@ -135,6 +138,7 @@ struct meson_mmc_data {
>>         unsigned int rx_delay_mask;
>>         unsigned int always_on;
>>         unsigned int adjust;
>> +       unsigned int irq_sdio_sleep;
>>  };
>>
>>  struct sd_emmc_desc {
>> @@ -174,6 +178,7 @@ struct meson_host {
>>         bool vqmmc_enabled;
>>         bool needs_pre_post_req;
>>
>> +       spinlock_t lock;
>>  };
>>
>>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
>> @@ -430,6 +435,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>         clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
>>         clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
>>         clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
>> +       clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
>>         writel(clk_reg, host->regs + SD_EMMC_CLOCK);
>>
>>         /* get the mux parents */
>> @@ -934,32 +940,54 @@ static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>>         }
>>  }
>>
>> +static void __meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>> +{
>> +       struct meson_host *host = mmc_priv(mmc);
>> +       u32 reg_irqen = IRQ_EN_MASK;
>> +
>> +       if (enable)
>> +               reg_irqen |= IRQ_SDIO;
>> +       writel(reg_irqen, host->regs + SD_EMMC_IRQ_EN);
>> +}
>> +
>>  static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>>  {
>>         struct meson_host *host = dev_id;
>>         struct mmc_command *cmd;
>> -       struct mmc_data *data;
>>         u32 status, raw_status;
>>         irqreturn_t ret = IRQ_NONE;
>>
>>         raw_status = readl(host->regs + SD_EMMC_STATUS);
>> -       status = raw_status & IRQ_EN_MASK;
>> +       status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
>>
>>         if (!status) {
>>                 dev_dbg(host->dev,
>>                         "Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
>> -                        IRQ_EN_MASK, raw_status);
>> +                        IRQ_EN_MASK | IRQ_SDIO, raw_status);
>>                 return IRQ_NONE;
>>         }
>>
>> -       if (WARN_ON(!host) || WARN_ON(!host->cmd))
>> +       if (WARN_ON(!host))
>>                 return IRQ_NONE;
>>
>>         /* ack all raised interrupts */
>>         writel(status, host->regs + SD_EMMC_STATUS);
>>
>>         cmd = host->cmd;
>> -       data = cmd->data;
>> +
>> +       if (status & IRQ_SDIO) {
>> +               spin_lock(&host->lock);
>> +               __meson_mmc_enable_sdio_irq(host->mmc, 0);
>> +               sdio_signal_irq(host->mmc);
>> +               spin_unlock(&host->lock);
>> +               status &= ~IRQ_SDIO;
>> +               if (!status)
>> +                       return IRQ_HANDLED;
>> +       }
>> +
>> +       if (WARN_ON(!cmd))
>> +               return IRQ_NONE;
>> +
>>         cmd->error = 0;
>>         if (status & IRQ_CRC_ERR) {
>>                 dev_dbg(host->dev, "CRC Error - status 0x%08x\n", status);
>> @@ -977,12 +1005,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>>
>>         meson_mmc_read_resp(host->mmc, cmd);
>>
>> -       if (status & IRQ_SDIO) {
>> -               dev_dbg(host->dev, "IRQ: SDIO TODO.\n");
>> -               ret = IRQ_HANDLED;
>> -       }
>> -
>>         if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
>> +               struct mmc_data *data = cmd->data;
>> +
>>                 if (data && !cmd->error)
>>                         data->bytes_xfered = data->blksz * data->blocks;
>>                 if (meson_mmc_bounce_buf_read(data) ||
>> @@ -1125,6 +1150,27 @@ static int meson_mmc_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>>         return -EINVAL;
>>  }
>>
>> +static void meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>> +{
>> +       struct meson_host *host = mmc_priv(mmc);
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +       __meson_mmc_enable_sdio_irq(mmc, enable);
>> +       spin_unlock_irqrestore(&host->lock, flags);
>> +}
>> +
>> +static void meson_mmc_ack_sdio_irq(struct mmc_host *mmc)
>> +{
>> +       struct meson_host *host = mmc_priv(mmc);
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&host->lock, flags);
>> +       if (!mmc->sdio_irq_pending)
> 
> I am not quite sure I understand why you need to check this flag here.
> 
> The point is, in meson_mmc_irq() you are doing things in the correct
> order, which means disabling the SDIO irq by calling
> __meson_mmc_enable_sdio_irq(host->mmc, 0) prior calling
> sdio_signal_irq(host->mmc) (which sets the flag).
> 
> In this way, the host driver should be prevented from signaling
> another new SDIO irq, until it has acked (which means re-enabling the
> SDIO irqs) the current one to be processed.
> 
> Or did I miss something?
> 

What could happen (at least based on the code):
Even though SDIO IRQ signalling is disabled we may receive another
interrupt that by chance has also the SDIO IRQ status bit set.
And if the hard irq handler interrupts sdio_run_irqs() here then
we may have a problem.

if (!host->sdio_irq_pending)
	host->ops->ack_sdio_irq(host);

Therefore the additional check (because checking the flag and calling
__meson_mmc_enable_sdio_irq() is protected by the spinlock).
However that's a theoretical worst case scenario. It don't know enough
about SDIO interrupts to state whether it actually can happen.

By the way: I'd also be reluctant to omit checking the SDIO IRQ status bit
if host->sdio_irq_pending is true because then we might miss a SDIO interrupt.

But if you say it's not needed I'll remove the duplicated flag check.

>> +               __meson_mmc_enable_sdio_irq(mmc, 1);
>> +       spin_unlock_irqrestore(&host->lock, flags);
>> +}
>>
> 
> [...]
> 
> Other than the comment above, the patch looks good to me!
> 
> Kind regards
> Uffe

