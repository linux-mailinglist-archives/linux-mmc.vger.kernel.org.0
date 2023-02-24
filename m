Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7BB6A1A1A
	for <lists+linux-mmc@lfdr.de>; Fri, 24 Feb 2023 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjBXKYB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 24 Feb 2023 05:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBXKXm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2023 05:23:42 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFDF4D611;
        Fri, 24 Feb 2023 02:23:14 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id w42so13943324qtc.2;
        Fri, 24 Feb 2023 02:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r881gtldlj9P8wXgRFt0iukIKePM4w44yZ83/Kol1e4=;
        b=Cx/jgpgF+z42DrLd7FPI+EjrTIVdmBohOt9Hv6cuajhuPux0ArqyMJli9L6vVrg5hU
         xszovY463dmdfmZ7WrgklIE1HvYi1cKG83BHqlv6cvoq48WUhVaaHGaTEhGS8dnR5F23
         3o2bxM/qvx5wD586Gza4OIe/pvzCPOb/gMux8grTTDgKjwrhAai+NEnWPATzCABRlRfY
         YpmR4cWj/4l9sZRnsk7ghyz157y61wvQsoeal+HA8tAT8sllM7TmoqXH7wZ9KnsXBzrm
         S0m73gTaJS2P6JXAh54r+ufFJOnTrGTSTDIpdBw8vechuLs//57Fc2LfcfUexenz2JTG
         I4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r881gtldlj9P8wXgRFt0iukIKePM4w44yZ83/Kol1e4=;
        b=goDNQhpGEfjKOwq8885XOuxdmyE4J31NtTD1XTex7b4ggXbZUcJxj5Zsm3oEiHkNHl
         3Jok6ZpU5ZweaVQYwe6QOTGwtA+iIqfTMqH72Et6gsMPN6tDrdYvhOrbKG0TlueBwvZ5
         Cs0+4/YPx/q9XI5N3+84c2O61O1HWogDokOKkAYLsQGlg2tMU7xgvN4L0aCyUg779TQf
         oQuIqTOtcorjoGr+oiIy77dhNNveKG6bbAiuFPnc2OuBKVPly4RiLTWOxYJ4KJa6kkXl
         objFUOqRT8QoerfINtAWFHwN7dMWNB5/xtiQTN0qkwpKIoOHPUd42Th9EI7w1bHxaXCS
         W6pQ==
X-Gm-Message-State: AO0yUKUCcQKaof/b7l2JQVmevqrGwU4majL8jyfH+Vp9yRRCClQNICfA
        6BZsQn3pONNRgExzl9Ff9mLemHYuzaXXT4uV9N0=
X-Google-Smtp-Source: AK7set8NwqqKVxfyGHJYCZ+YsZEi26pNrrfeakRWzXCcekY8VIqXYZgE5Lh+zi0WrwHVIXuwjCuLgfDXMG5W837TfGc=
X-Received: by 2002:ac8:4312:0:b0:3bf:b95e:1768 with SMTP id
 z18-20020ac84312000000b003bfb95e1768mr645197qtm.10.1677234193201; Fri, 24 Feb
 2023 02:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-21-victor.shih@genesyslogic.com.tw> <9e15d6a8-6e98-4322-b3b9-0d8b0296dc63@intel.com>
In-Reply-To: <9e15d6a8-6e98-4322-b3b9-0d8b0296dc63@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 24 Feb 2023 18:23:01 +0800
Message-ID: <CAK00qKD3YTUs9u+vxzoz=iMEKNL7av75Qp7fG22xZx2m2-i88w@mail.gmail.com>
Subject: Re: [PATCH V6 20/24] mmc: sdhci-uhs2: add add_host() and others to
 set up the driver
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, Adrian

On Fri, Jan 6, 2023 at 5:30 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/12/22 11:00, Victor Shih wrote:
> > This is a UHS-II version of sdhci's add_host/remove_host operation.
> > Any sdhci drivers which are capable of handling UHS-II cards must
> > call those functions instead of the corresponding sdhci's.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 171 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |   2 +
> >  drivers/mmc/host/sdhci.c      |  28 ++++--
> >  drivers/mmc/host/sdhci.h      |  12 +++
> >  4 files changed, 204 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 769cf88b21cf..5349173b4f90 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/ktime.h>
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/dmaengine.h>
> > +#include <linux/regulator/consumer.h>
> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -1015,6 +1016,176 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
> >       return IRQ_HANDLED;
> >  }
> >
> > +/*****************************************************************************\
> > + *
> > + * Device allocation/registration                                            *
> > + *                                                                           *
> > +\*****************************************************************************/
> > +
> > +static int __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
> > +{
> > +     struct mmc_host *mmc;
> > +     u32 max_current_caps2;
> > +
> > +     if (host->version < SDHCI_SPEC_400)
> > +             return 0;
> > +
> > +     mmc = host->mmc;
> > +
> > +     /* Support UHS2 */
> > +     if (caps1 & SDHCI_SUPPORT_UHS2)
> > +             mmc->caps2 |= MMC_CAP2_SD_UHS2;
> > +
> > +     max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
> > +
> > +     if ((caps1 & SDHCI_CAN_VDD2_180) &&
> > +         !max_current_caps2 &&
> > +         !IS_ERR(mmc->supply.vmmc2)) {
> > +             /* UHS2 - VDD2 */
> > +             int curr = regulator_get_current_limit(mmc->supply.vmmc2);
> > +
> > +             if (curr > 0) {
> > +                     /* convert to SDHCI_MAX_CURRENT format */
> > +                     curr = curr / 1000;  /* convert to mA */
> > +                     curr = curr / SDHCI_MAX_CURRENT_MULTIPLIER;
> > +                     curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
> > +                     max_current_caps2 = curr;
> > +             }
> > +     }
> > +
> > +     if (caps1 & SDHCI_CAN_VDD2_180) {
> > +             mmc->ocr_avail_uhs2 |= MMC_VDD2_165_195;
> > +             /*
> > +              * UHS2 doesn't require this. Only UHS-I bus needs to set
> > +              * max current.
> > +              */
> > +             mmc->max_current_180_vdd2 = (max_current_caps2 &
> > +                                     SDHCI_MAX_CURRENT_VDD2_180_MASK) *
> > +                                     SDHCI_MAX_CURRENT_MULTIPLIER;
> > +     } else {
> > +             mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
> > +
> > +static int __sdhci_uhs2_add_host(struct sdhci_host *host)
> > +{
> > +     unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI;
> > +     struct mmc_host *mmc = host->mmc;
> > +     int ret;
> > +
> > +     if ((mmc->caps2 & MMC_CAP2_CQE) &&
> > +         (host->quirks & SDHCI_QUIRK_BROKEN_CQE)) {
> > +             mmc->caps2 &= ~MMC_CAP2_CQE;
> > +             mmc->cqe_ops = NULL;
> > +     }
> > +
> > +     host->complete_wq = alloc_workqueue("sdhci", flags, 0);
> > +     if (!host->complete_wq)
> > +             return -ENOMEM;
> > +
> > +     INIT_WORK(&host->complete_work, host->complete_work_fn);
> > +
> > +     timer_setup(&host->timer, sdhci_timeout_timer, 0);
> > +     timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
> > +
> > +     init_waitqueue_head(&host->buf_ready_int);
> > +
> > +     sdhci_init(host, 0);
> > +
> > +     ret = request_threaded_irq(host->irq, sdhci_irq,
> > +                                host->thread_irq_fn,
> > +                                IRQF_SHARED, mmc_hostname(mmc), host);
> > +     if (ret) {
> > +             pr_err("%s: Failed to request IRQ %d: %d\n",
> > +                    mmc_hostname(mmc), host->irq, ret);
> > +             goto unwq;
> > +     }
> > +
> > +     ret = mmc_add_host(mmc);
> > +             if (ret)
> > +                     return 1;
> > +
> > +     pr_info("%s: SDHCI controller on %s [%s] using %s\n",
> > +             mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
> > +             host->use_external_dma ? "External DMA" :
> > +             (host->flags & SDHCI_USE_ADMA) ?
> > +             (host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
> > +             (host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
> > +
> > +     sdhci_enable_card_detection(host);
> > +
> > +     return 0;
> > +
> > +unwq:
> > +     destroy_workqueue(host->complete_wq);
> > +
> > +     return ret;
> > +}
> > +
> > +static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
> > +{
> > +     if (!sdhci_uhs2_mode(host))
> > +             return;
> > +
> > +     if (!dead)
> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
> > +}
> > +
> > +int sdhci_uhs2_add_host(struct sdhci_host *host)
> > +{
> > +     struct mmc_host *mmc = host->mmc;
> > +     int ret;
> > +
> > +     ret = sdhci_setup_host(host);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (host->version >= SDHCI_SPEC_400) {
> > +             ret = __sdhci_uhs2_add_host_v4(host, host->caps1);
> > +             if (ret)
> > +                     goto cleanup;
> > +     }
> > +
> > +     if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
> > +             /* host doesn't want to enable UHS2 support */
> > +             /* FIXME: Do we have to do some cleanup here? */
> > +             mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
> > +
> > +     /* overwrite ops */
> > +     if (mmc->caps2 & MMC_CAP2_SD_UHS2)
> > +             sdhci_uhs2_host_ops_init(host);
> > +
> > +     host->complete_work_fn = sdhci_uhs2_complete_work;
> > +     host->thread_irq_fn    = sdhci_uhs2_thread_irq;
> > +
> > +     ret = __sdhci_uhs2_add_host(host);
>
> Please just use __sdhci_add_host() and __sdhci_uhs2_add_host()
> is not needed. i.e.
>
>         /* LED support not implemented for UHS2 */
>         host->quirks |= SDHCI_QUIRK_NO_LED;
>
>         ret = __sdhci_add_host(host);
>

I will update it in V7 version.

> > +     if (ret)
> > +             goto cleanup2;
> > +
> > +     return 0;
> > +
> > +cleanup2:
> > +     if (host->version >= SDHCI_SPEC_400)
> > +             __sdhci_uhs2_remove_host(host, 0);
> > +cleanup:
> > +     sdhci_cleanup_host(host);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
> > +
> > +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
> > +{
> > +     __sdhci_uhs2_remove_host(host, dead);
> > +
> > +     sdhci_remove_host(host, dead);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
> > +
> >  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  {
> >       struct sdhci_host *host = mmc_priv(mmc);
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index 64b7f356c9fc..b2048c48d056 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -182,5 +182,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
> >  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
> >  int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
> >  u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> > +int sdhci_uhs2_add_host(struct sdhci_host *host);
> > +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 6c67b79102eb..82ad35f4d1b4 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -175,10 +175,11 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
> >       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> >  }
> >
> > -static void sdhci_enable_card_detection(struct sdhci_host *host)
> > +void sdhci_enable_card_detection(struct sdhci_host *host)
> >  {
> >       sdhci_set_card_detection(host, true);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_enable_card_detection);
>
> sdhci_enable_card_detection() does not need to be exported
> when __sdhci_uhs2_add_host() is not needed anymore
>

I will update it in V7 version.

> >
> >  static void sdhci_disable_card_detection(struct sdhci_host *host)
> >  {
> > @@ -369,7 +370,7 @@ static void sdhci_config_dma(struct sdhci_host *host)
> >       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> >  }
> >
> > -static void sdhci_init(struct sdhci_host *host, int soft)
> > +void sdhci_init(struct sdhci_host *host, int soft)
> >  {
> >       struct mmc_host *mmc = host->mmc;
> >       unsigned long flags;
> > @@ -395,6 +396,7 @@ static void sdhci_init(struct sdhci_host *host, int soft)
> >               mmc->ops->set_ios(mmc, &mmc->ios);
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_init);
>
> Does not need to be exported when __sdhci_uhs2_add_host()
> is not needed anymore
>

I will update it in V7 version.

> >
> >  static void sdhci_reinit(struct sdhci_host *host)
> >  {
> > @@ -458,7 +460,7 @@ static void sdhci_led_control(struct led_classdev *led,
> >       spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> > -static int sdhci_led_register(struct sdhci_host *host)
> > +int sdhci_led_register(struct sdhci_host *host)
> >  {
> >       struct mmc_host *mmc = host->mmc;
> >
> > @@ -475,14 +477,16 @@ static int sdhci_led_register(struct sdhci_host *host)
> >
> >       return led_classdev_register(mmc_dev(mmc), &host->led);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_led_register);
>
> sdhci_led_register does not need export
>

I will update it in V7 version.

> >
> > -static void sdhci_led_unregister(struct sdhci_host *host)
> > +void sdhci_led_unregister(struct sdhci_host *host)
> >  {
> >       if (host->quirks & SDHCI_QUIRK_NO_LED)
> >               return;
> >
> >       led_classdev_unregister(&host->led);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_led_unregister);
>
> sdhci_led_unregister does not need export
>

I will update it in V7 version.

> >
> >  static inline void sdhci_led_activate(struct sdhci_host *host)
> >  {
> > @@ -3265,7 +3269,7 @@ void sdhci_complete_work(struct work_struct *work)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_complete_work);
> >
> > -static void sdhci_timeout_timer(struct timer_list *t)
> > +void sdhci_timeout_timer(struct timer_list *t)
> >  {
> >       struct sdhci_host *host;
> >       unsigned long flags;
> > @@ -3286,8 +3290,9 @@ static void sdhci_timeout_timer(struct timer_list *t)
> >
> >       spin_unlock_irqrestore(&host->lock, flags);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_timeout_timer);
>
> sdhci_timeout_timer() does not need export
> when __sdhci_uhs2_add_host() is not needed anymore
>

I will update it in V7 version.

> >
> > -static void sdhci_timeout_data_timer(struct timer_list *t)
> > +void sdhci_timeout_data_timer(struct timer_list *t)
> >  {
> >       struct sdhci_host *host;
> >       unsigned long flags;
> > @@ -3318,6 +3323,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
> >
> >       spin_unlock_irqrestore(&host->lock, flags);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_timeout_data_timer);
>
> sdhci_timeout_data_timer() does not need export
> when __sdhci_uhs2_add_host() is not needed anymore
>

I will update it in V7 version.

> >
> >  /*****************************************************************************\
> >   *                                                                           *
> > @@ -3577,7 +3583,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
> >               data->host_cookie == COOKIE_MAPPED);
> >  }
> >
> > -static irqreturn_t sdhci_irq(int irq, void *dev_id)
> > +irqreturn_t sdhci_irq(int irq, void *dev_id)
> >  {
> >       struct mmc_request *mrqs_done[SDHCI_MAX_MRQS] = {0};
> >       irqreturn_t result = IRQ_NONE;
> > @@ -3718,6 +3724,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> >
> >       return result;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_irq);
>
> sdhci_irq() does not need export
> when __sdhci_uhs2_add_host() is not needed anymore
>

I will update it in V7 version.

> >
> >  irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> >  {
> > @@ -4122,6 +4129,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
> >
> >       host->max_timeout_count = 0xE;
> >
> > +     host->complete_work_fn = sdhci_complete_work;
> > +     host->thread_irq_fn    = sdhci_thread_irq;
> > +
> >       return host;
> >  }
> >
> > @@ -4874,7 +4884,7 @@ int __sdhci_add_host(struct sdhci_host *host)
> >       if (!host->complete_wq)
> >               return -ENOMEM;
> >
> > -     INIT_WORK(&host->complete_work, sdhci_complete_work);
> > +     INIT_WORK(&host->complete_work, host->complete_work_fn);
> >
> >       timer_setup(&host->timer, sdhci_timeout_timer, 0);
> >       timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
> > @@ -4883,7 +4893,7 @@ int __sdhci_add_host(struct sdhci_host *host)
> >
> >       sdhci_init(host, 0);
> >
> > -     ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
> > +     ret = request_threaded_irq(host->irq, sdhci_irq, host->thread_irq_fn,
> >                                  IRQF_SHARED, mmc_hostname(mmc), host);
> >       if (ret) {
> >               pr_err("%s: Failed to request IRQ %d: %d\n",
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 4979af7cabca..5f090b5ecc61 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -629,6 +629,9 @@ struct sdhci_host {
> >       struct timer_list timer;        /* Timer for timeouts */
> >       struct timer_list data_timer;   /* Timer for data timeouts */
> >
> > +     void            (*complete_work_fn)(struct work_struct *work);
> > +     irqreturn_t     (*thread_irq_fn)(int irq, void *dev_id);
> > +
> >  #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> >       struct dma_chan *rx_chan;
> >       struct dma_chan *tx_chan;
> > @@ -832,6 +835,12 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
> >  }
> >
> >  bool sdhci_data_line_cmd(struct mmc_command *cmd);
> > +void sdhci_enable_card_detection(struct sdhci_host *host);
> > +void sdhci_init(struct sdhci_host *host, int soft);
> > +#if IS_REACHABLE(CONFIG_LEDS_CLASS)
> > +int sdhci_led_register(struct sdhci_host *host);
> > +void sdhci_led_unregister(struct sdhci_host *host);
> > +#endif
>
> Export of sdhci_led_register and sdhci_led_unregister
> is not needed
>

I will update it in V7 version.

> >  void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
> >  void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
> >  void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> > @@ -875,6 +884,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> >  void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
> >  void sdhci_complete_work(struct work_struct *work);
> > +void sdhci_timeout_timer(struct timer_list *t);
> > +void sdhci_timeout_data_timer(struct timer_list *t);
>
> sdhci_timeout_timer() and sdhci_timeout_data_timer()
> do not need export when __sdhci_uhs2_add_host()
> is not needed anymore
>

I will update it in V7 version.

> > +irqreturn_t sdhci_irq(int irq, void *dev_id);
>
> sdhci_irq() does not need export
> when __sdhci_uhs2_add_host() is not needed anymore
>

I will update it in V7 version.

> >  irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
> >  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> >                          dma_addr_t addr, int len, unsigned int cmd);
>

Thanks, Victor Shih
