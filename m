Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E9A5112A7
	for <lists+linux-mmc@lfdr.de>; Wed, 27 Apr 2022 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbiD0Hjt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 27 Apr 2022 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358917AbiD0Hji (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 03:39:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45081B1880
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2022 00:36:27 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q14so1469467ljc.12
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2022 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOWXt0RCkmNwqnr1vpuLgtkBEkSNzh3X948zHjwOXOk=;
        b=rVeV+ecRbV9U4suCntKw6yAmdK+/REz/nSb0stWVo8DkXseuWJSJPFf7XimE2crp6m
         HWPLIJMdVtFVJKaChG9kdZogk7PB9KSVV8iY8nB4T1fIiCNI7KDSCDAcMkmxBg19SNZs
         W5H7u/OvKKfbcFlcaDunkUi/L5eQ0A6UZWv21qst267X+gGJbOqeaMtB39ujUrOp1lx0
         JdUtSR5MG9PCUs1PWEb1qdJtXBBPNNVwdsRC6ThQo9H0HXYY3uzIdATAvEKg7cj9CD9x
         Sk8auMRPiM4Q/9ZA2h2IWoGtsMqhKhhV7R38Q//wpNjjsIjFVDje0QhUtnLcq5MLgn6c
         JK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOWXt0RCkmNwqnr1vpuLgtkBEkSNzh3X948zHjwOXOk=;
        b=FCXLSi+nQzFWo0iWTBa7h+kvhE5Q7F4+LdtGilfjzyY+4TUraQFwXWUyedxGV9qAIV
         OWaRZl9WdYspuSJbG4Qt4EM+25Pr866UQcb1YpzXEwo5/zth4FKTC7fXFlHnvnGt3tD4
         2lMZN/hvH8yXTRYfUfdU+81+yS2YvRnRxYh9Oow+KN6cuv4ktihAO0/GAz2Yvzem0maz
         FwuMr2XlJFaSqLoVOMoQqPr9/5tVr4PUx2DJPGDDMjNXvBVF5Ot6PnGEb4uuH39X7NF7
         eHO/Sq2Mzo61FKuwx+gN0FuZvOJbXXfRFKeXTpNMCu9+colLzyex54hv2Q/98sv1QOHZ
         4dAg==
X-Gm-Message-State: AOAM5320xY2rpNskREwenINk2IKyrHGyF2KeQkbtdi8Kq7iTWx+fM0qh
        Wk3ipo5AnHqc0aDx5JY25hcSL7P6UjoANDBawukMaA==
X-Google-Smtp-Source: ABdhPJwyus3u7jQu2n+R6pq5Lp9Tf9kdvJ2wBA/Jt3roNcXOBufqH7+09+kyjgCE2+zxsRnAZss7WPQRv91soRDJCiA=
X-Received: by 2002:a05:651c:988:b0:24a:c21f:7057 with SMTP id
 b8-20020a05651c098800b0024ac21f7057mr17362084ljq.16.1651044985287; Wed, 27
 Apr 2022 00:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
In-Reply-To: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Apr 2022 09:35:47 +0200
Message-ID: <CAPDyKFo7H=fOiX49gttrKO3gwe=ddYMjdgrO_xSnnZjZh7P7ZA@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Add partial initialization support
To:     Srinivasarao Pathipati <quic_spathi@quicinc.com>
Cc:     avri.altman@wdc.com, linus.walleij@linaro.org,
        shawn.lin@rock-chips.com, merez@codeaurora.org, s.shtylyov@omp.ru,
        huijin.park@samsung.com, briannorris@chromium.org,
        digetx@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kamasali <quic_kamasali@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Apr 2022 at 11:04, Srinivasarao Pathipati
<quic_spathi@quicinc.com> wrote:
>
> From: Maya Erez <merez@codeaurora.org>
>
> This change adds the ability to partially initialize
> the MMC card by using card Sleep/Awake sequence (CMD5).
> Card will be sent to Sleep state during runtime/system suspend
> and will be woken up during runtime/system resume.
> By using this sequence the card doesn't need full initialization
> which gives time reduction in system/runtime resume path.
>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> Signed-off-by: kamasali <quic_kamasali@quicinc.com>
> Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>

It seems like this patch has been posted before [1]. Let me repeat my
question sent back then.

It would be nice if you could provide some more exact numbers of what
the gain is for a couple of different eMMCs, to justify the change.
Can you please do that?

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-mmc/patch/1591277381-7734-1-git-send-email-vbadigan@codeaurora.org/

> ---
>  drivers/mmc/core/mmc.c   | 149 ++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/mmc/card.h |   4 ++
>  include/linux/mmc/host.h |   2 +
>  3 files changed, 146 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9ab915b..8691c00 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1942,7 +1942,14 @@ static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
>         return 0;
>  }
>
> -static int mmc_sleep(struct mmc_host *host)
> +static int mmc_can_sleepawake(struct mmc_host *host)
> +{
> +       return host && (host->caps2 & MMC_CAP2_SLEEP_AWAKE) && host->card &&
> +               (host->card->ext_csd.rev >= 3);
> +
> +}
> +
> +static int mmc_sleepawake(struct mmc_host *host, bool sleep)
>  {
>         struct mmc_command cmd = {};
>         struct mmc_card *card = host->card;
> @@ -1953,14 +1960,17 @@ static int mmc_sleep(struct mmc_host *host)
>         /* Re-tuning can't be done once the card is deselected */
>         mmc_retune_hold(host);
>
> -       err = mmc_deselect_cards(host);
> -       if (err)
> -               goto out_release;
> +       if (sleep) {
> +               err = mmc_deselect_cards(host);
> +               if (err)
> +                       goto out_release;
> +       }
>
>         cmd.opcode = MMC_SLEEP_AWAKE;
>         cmd.arg = card->rca << 16;
> -       cmd.arg |= 1 << 15;
>         use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
> +       if (sleep)
> +               cmd.arg |= 1 << 15;
>
>         err = mmc_wait_for_cmd(host, &cmd, 0);
>         if (err)
> @@ -1982,6 +1992,9 @@ static int mmc_sleep(struct mmc_host *host)
>
>         err = __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_cb, host);
>
> +       if (!sleep)
> +               err = mmc_select_card(card);
> +
>  out_release:
>         mmc_retune_release(host);
>         return err;
> @@ -2080,6 +2093,66 @@ static int _mmc_flush_cache(struct mmc_host *host)
>                         pr_err("%s: cache flush error %d\n",
>                                mmc_hostname(host), err);
>         }
> +       return err;
> +}
> +
> +static int mmc_cache_card_ext_csd(struct mmc_host *host)
> +{
> +       int err;
> +       u8 *ext_csd;
> +       struct mmc_card *card = host->card;
> +
> +       err = mmc_get_ext_csd(card, &ext_csd);
> +       if (err || !ext_csd) {
> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> +                       mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +       /* only cache read/write fields that the sw changes */
> +       card->ext_csd.raw_ext_csd_cmdq = ext_csd[EXT_CSD_CMDQ_MODE_EN];
> +       card->ext_csd.raw_ext_csd_cache_ctrl = ext_csd[EXT_CSD_CACHE_CTRL];
> +       card->ext_csd.raw_ext_csd_bus_width = ext_csd[EXT_CSD_BUS_WIDTH];
> +       card->ext_csd.raw_ext_csd_hs_timing = ext_csd[EXT_CSD_HS_TIMING];
> +
> +       kfree(ext_csd);
> +
> +       return 0;
> +}
> +
> +static int mmc_test_awake_ext_csd(struct mmc_host *host)
> +{
> +       int err;
> +       u8 *ext_csd;
> +       struct mmc_card *card = host->card;
> +
> +       err = mmc_get_ext_csd(card, &ext_csd);
> +       if (err) {
> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> +                       mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /* only compare read/write fields that the sw changes */
> +       pr_debug("%s: %s: type(cached:current) cmdq(%d:%d) cache_ctrl(%d:%d) bus_width (%d:%d) timing(%d:%d)\n",
> +               mmc_hostname(host), __func__,
> +               card->ext_csd.raw_ext_csd_cmdq,
> +               ext_csd[EXT_CSD_CMDQ_MODE_EN],
> +               card->ext_csd.raw_ext_csd_cache_ctrl,
> +               ext_csd[EXT_CSD_CACHE_CTRL],
> +               card->ext_csd.raw_ext_csd_bus_width,
> +               ext_csd[EXT_CSD_BUS_WIDTH],
> +               card->ext_csd.raw_ext_csd_hs_timing,
> +               ext_csd[EXT_CSD_HS_TIMING]);
> +       err = !((card->ext_csd.raw_ext_csd_cmdq ==
> +                       ext_csd[EXT_CSD_CMDQ_MODE_EN]) &&
> +               (card->ext_csd.raw_ext_csd_cache_ctrl ==
> +                       ext_csd[EXT_CSD_CACHE_CTRL]) &&
> +               (card->ext_csd.raw_ext_csd_bus_width ==
> +                       ext_csd[EXT_CSD_BUS_WIDTH]) &&
> +               (card->ext_csd.raw_ext_csd_hs_timing ==
> +                       ext_csd[EXT_CSD_HS_TIMING]));
> +
> +       kfree(ext_csd);
>
>         return err;
>  }
> @@ -2103,8 +2176,12 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>             ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
>              (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
>                 err = mmc_poweroff_notify(host->card, notify_type);
> -       else if (mmc_can_sleep(host->card))
> -               err = mmc_sleep(host);
> +       if (mmc_can_sleepawake(host)) {
> +               memcpy(&host->cached_ios, &host->ios, sizeof(host->cached_ios));
> +                mmc_cache_card_ext_csd(host);
> +       }
> +       if (mmc_can_sleep(host->card))
> +               err = mmc_sleepawake(host, true);
>         else if (!mmc_host_is_spi(host))
>                 err = mmc_deselect_cards(host);
>
> @@ -2117,6 +2194,48 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>         return err;
>  }
>
> +static int mmc_partial_init(struct mmc_host *host)
> +{
> +       int err = 0;
> +       struct mmc_card *card = host->card;
> +
> +       mmc_set_bus_width(host, host->cached_ios.bus_width);
> +       mmc_set_timing(host, host->cached_ios.timing);
> +       if (host->cached_ios.enhanced_strobe) {
> +               host->ios.enhanced_strobe = true;
> +               if (host->ops->hs400_enhanced_strobe)
> +                       host->ops->hs400_enhanced_strobe(host, &host->ios);
> +       }
> +       mmc_set_clock(host, host->cached_ios.clock);
> +       mmc_set_bus_mode(host, host->cached_ios.bus_mode);
> +
> +       if (!mmc_card_hs400es(card) &&
> +                       (mmc_card_hs200(card) || mmc_card_hs400(card))) {
> +               err = mmc_execute_tuning(card);
> +               if (err) {
> +                       pr_err("%s: %s: Tuning failed (%d)\n",
> +                               mmc_hostname(host), __func__, err);
> +                       goto out;
> +               }
> +       }
> +       /*
> +        * The ext_csd is read to make sure the card did not went through
> +        * Power-failure during sleep period.
> +        * A subset of the W/E_P, W/C_P register will be tested. In case
> +        * these registers values are different from the values that were
> +        * cached during suspend, we will conclude that a Power-failure occurred
> +        * and will do full initialization sequence.
> +        */
> +       err = mmc_test_awake_ext_csd(host);
> +       if (err) {
> +               pr_debug("%s: %s: fail on ext_csd read (%d)\n",
> +                       mmc_hostname(host), __func__, err);
> +               goto out;
> +       }
> +out:
> +       return err;
> +}
> +
>  /*
>   * Suspend callback
>   */
> @@ -2139,7 +2258,7 @@ static int mmc_suspend(struct mmc_host *host)
>   */
>  static int _mmc_resume(struct mmc_host *host)
>  {
> -       int err = 0;
> +       int err = -EINVAL;
>
>         mmc_claim_host(host);
>
> @@ -2147,7 +2266,19 @@ static int _mmc_resume(struct mmc_host *host)
>                 goto out;
>
>         mmc_power_up(host, host->card->ocr);
> -       err = mmc_init_card(host, host->card->ocr, host->card);
> +
> +       if (mmc_can_sleepawake(host)) {
> +               err = mmc_sleepawake(host, false);
> +               if (!err)
> +                       err = mmc_partial_init(host);
> +               else
> +                       pr_err("%s: %s: awake failed (%d), fallback to full init\n",
> +                               mmc_hostname(host), __func__, err);
> +       }
> +
> +       if (err)
> +               err = mmc_init_card(host, host->card->ocr, host->card);
> +
>         mmc_card_clr_suspended(host->card);
>
>  out:
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 37f9758..ed7f6f7 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -86,6 +86,8 @@ struct mmc_ext_csd {
>         unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>         unsigned int            boot_ro_lock;           /* ro lock support */
>         bool                    boot_ro_lockable;
> +       u8                      raw_ext_csd_cmdq;       /* 15 */
> +       u8                      raw_ext_csd_cache_ctrl; /* 33 */
>         bool                    ffu_capable;    /* Firmware upgrade support */
>         bool                    cmdq_en;        /* Command Queue enabled */
>         bool                    cmdq_support;   /* Command Queue supported */
> @@ -96,7 +98,9 @@ struct mmc_ext_csd {
>         u8                      raw_partition_support;  /* 160 */
>         u8                      raw_rpmb_size_mult;     /* 168 */
>         u8                      raw_erased_mem_count;   /* 181 */
> +       u8                      raw_ext_csd_bus_width;  /* 183 */
>         u8                      strobe_support;         /* 184 */
> +       u8                      raw_ext_csd_hs_timing;  /* 185 */
>         u8                      raw_ext_csd_structure;  /* 194 */
>         u8                      raw_card_type;          /* 196 */
>         u8                      raw_driver_strength;    /* 197 */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c38072e..a9ddf7a 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -422,6 +422,7 @@ struct mmc_host {
>  #else
>  #define MMC_CAP2_CRYPTO                0
>  #endif
> +#define MMC_CAP2_SLEEP_AWAKE   (1 << 29)       /* Use Sleep/Awake (CMD5) */
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that has GPT entry at a non-standard location */
>
>         int                     fixed_drv_type; /* fixed driver type for non-removable media */
> @@ -441,6 +442,7 @@ struct mmc_host {
>         spinlock_t              lock;           /* lock for claim and bus ops */
>
>         struct mmc_ios          ios;            /* current io bus settings */
> +       struct mmc_ios          cached_ios;
>
>         /* group bitfields together to minimize padding */
>         unsigned int            use_spi_crc:1;
> --
> 2.7.4
>
