Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C51DEB3A
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfJULoh (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 07:44:37 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39472 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfJULoh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 07:44:37 -0400
Received: by mail-ua1-f67.google.com with SMTP id b14so3699962uap.6
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSg26SWjQFt8SFFEyx8QZDcv+KIUSNzw/5kl16s+Vj0=;
        b=PsyBUKS7aYmTFIsiINdVGdDnLFZMUIHW7hGfjzj6h8j52Dpdn10FVdqf+LuVW60OKY
         ckvqCloEO+aA8MIejDEZkw29Xs2loC2DtjP6Un4ZOZ5cK4ONnTCdGUhavne9NG6v8sBH
         DzgTIZsHluqz2GJJqiQlSQOJVzA8PGfTWWcM1A9swf78nuHux62KdVruzexhMAAozU71
         XnIMeJz/vEuFImP/kVlrz4bW8GK80X6VeOJWMShrL2KZRwo7prJbEEojxUFzjGLkmmiv
         svP41lv7/wlnMvQ/8YCVxQoXblrHSujTXQOzOPg7hcG/9lpf78piC1R0pKpTQ0P/nEIK
         kVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSg26SWjQFt8SFFEyx8QZDcv+KIUSNzw/5kl16s+Vj0=;
        b=XvjQOMW8q88TIyfdHQth0NhnjsWgsVLOJx3eKV7AVhvTeem2qT1Y0zAuGFC1egsOJK
         H25GIeb9uQTz4sb8RcrFOOnmLvkYVfePf6E8vWX7k19m7f/XmAxVpx+uDISCwiEqhtw/
         3qlf4xnNgHoezDmyGYpNfA23KbSz/K4Cfl6kPf2wufbCazfCRcDp9Ffd2m+4i0c9TiJI
         ibCNz9QNvK5IcgrTlcTD4+RRAwKDSUh2/rnTsCy1yZ21GASI07ZeaKvlUSJzEi9oX9oB
         Ab4fyQaW4BDYpCdPPTcwNHz8pTooxBjRiUzKut54jHa/bGxwb5MhKqFI14/cIDO4E6ZY
         BKPg==
X-Gm-Message-State: APjAAAXVAtT59fMtbR/T7Lvvx34d67eGDLVwh6YnucMsYum0Xqve0eUo
        a6toaoxgq4f9vbqCXdVw84FBoMAKD4RkpwT13XUWHQ==
X-Google-Smtp-Source: APXvYqx+TBsQJDgF01IGB4FH9mUGStVZN4fWPZ1N/cuN6TP1mpjsFqTYHKcfyhRphAaArZxZTabYiicePr18BMtcdBg=
X-Received: by 2002:ab0:348c:: with SMTP id c12mr8377699uar.100.1571658275446;
 Mon, 21 Oct 2019 04:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190905075318.15554-1-chaotian.jing@mediatek.com> <20190905075318.15554-3-chaotian.jing@mediatek.com>
In-Reply-To: <20190905075318.15554-3-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Oct 2019 13:43:59 +0200
Message-ID: <CAPDyKFp7cmWpD_9TUR2bPArGevo9M82MTff0RQ-Ly-+L7t5pHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Avri Altman <avri.altman@wdc.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>,
        Zachary Hays <zhays@lexmark.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Sep 2019 at 09:53, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> currently there is no CMD13 polling and other code to wait card
> change to transfer state after R1B command completed. and this
> polling operation cannot do in user space, because other request
> may coming before the CMD13 from user space.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Both patch 1 and patch2, looks like material for stable, so unless
someone objects I am adding a tag for that.

Moreover, I updated the changelogs, also according to suggestions from
Avri and then applied both patches for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 146 +++++++++++++++------------------------
>  1 file changed, 55 insertions(+), 91 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index aa7c19f7e298..ee1fd7df4ec8 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -408,38 +408,6 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
>         return 0;
>  }
>
> -static int ioctl_rpmb_card_status_poll(struct mmc_card *card, u32 *status,
> -                                      u32 retries_max)
> -{
> -       int err;
> -       u32 retry_count = 0;
> -
> -       if (!status || !retries_max)
> -               return -EINVAL;
> -
> -       do {
> -               err = __mmc_send_status(card, status, 5);
> -               if (err)
> -                       break;
> -
> -               if (!R1_STATUS(*status) &&
> -                               (R1_CURRENT_STATE(*status) != R1_STATE_PRG))
> -                       break; /* RPMB programming operation complete */
> -
> -               /*
> -                * Rechedule to give the MMC device a chance to continue
> -                * processing the previous command without being polled too
> -                * frequently.
> -                */
> -               usleep_range(1000, 5000);
> -       } while (++retry_count < retries_max);
> -
> -       if (retry_count == retries_max)
> -               err = -EPERM;
> -
> -       return err;
> -}
> -
>  static int ioctl_do_sanitize(struct mmc_card *card)
>  {
>         int err;
> @@ -468,6 +436,58 @@ static int ioctl_do_sanitize(struct mmc_card *card)
>         return err;
>  }
>
> +static inline bool mmc_blk_in_tran_state(u32 status)
> +{
> +       /*
> +        * Some cards mishandle the status bits, so make sure to check both the
> +        * busy indication and the card state.
> +        */
> +       return status & R1_READY_FOR_DATA &&
> +              (R1_CURRENT_STATE(status) == R1_STATE_TRAN);
> +}
> +
> +static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
> +                           u32 *resp_errs)
> +{
> +       unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +       int err = 0;
> +       u32 status;
> +
> +       do {
> +               bool done = time_after(jiffies, timeout);
> +
> +               err = __mmc_send_status(card, &status, 5);
> +               if (err) {
> +                       dev_err(mmc_dev(card->host),
> +                               "error %d requesting status\n", err);
> +                       return err;
> +               }
> +
> +               /* Accumulate any response error bits seen */
> +               if (resp_errs)
> +                       *resp_errs |= status;
> +
> +               /*
> +                * Timeout if the device never becomes ready for data and never
> +                * leaves the program state.
> +                */
> +               if (done) {
> +                       dev_err(mmc_dev(card->host),
> +                               "Card stuck in wrong state! %s status: %#x\n",
> +                                __func__, status);
> +                       return -ETIMEDOUT;
> +               }
> +
> +               /*
> +                * Some cards mishandle the status bits,
> +                * so make sure to check both the busy
> +                * indication and the card state.
> +                */
> +       } while (!mmc_blk_in_tran_state(status));
> +
> +       return err;
> +}
> +
>  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>                                struct mmc_blk_ioc_data *idata)
>  {
> @@ -611,16 +631,12 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>
>         memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
>
> -       if (idata->rpmb) {
> +       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B)) {
>                 /*
> -                * Ensure RPMB command has completed by polling CMD13
> +                * Ensure RPMB/R1B command has completed by polling CMD13
>                  * "Send Status".
>                  */
> -               err = ioctl_rpmb_card_status_poll(card, &status, 5);
> -               if (err)
> -                       dev_err(mmc_dev(card->host),
> -                                       "%s: Card Status=0x%08X, error %d\n",
> -                                       __func__, status, err);
> +               err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
>         }
>
>         return err;
> @@ -970,58 +986,6 @@ static unsigned int mmc_blk_data_timeout_ms(struct mmc_host *host,
>         return ms;
>  }
>
> -static inline bool mmc_blk_in_tran_state(u32 status)
> -{
> -       /*
> -        * Some cards mishandle the status bits, so make sure to check both the
> -        * busy indication and the card state.
> -        */
> -       return status & R1_READY_FOR_DATA &&
> -              (R1_CURRENT_STATE(status) == R1_STATE_TRAN);
> -}
> -
> -static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
> -                           u32 *resp_errs)
> -{
> -       unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> -       int err = 0;
> -       u32 status;
> -
> -       do {
> -               bool done = time_after(jiffies, timeout);
> -
> -               err = __mmc_send_status(card, &status, 5);
> -               if (err) {
> -                       dev_err(mmc_dev(card->host),
> -                               "error %d requesting status\n", err);
> -                       return err;
> -               }
> -
> -               /* Accumulate any response error bits seen */
> -               if (resp_errs)
> -                       *resp_errs |= status;
> -
> -               /*
> -                * Timeout if the device never becomes ready for data and never
> -                * leaves the program state.
> -                */
> -               if (done) {
> -                       dev_err(mmc_dev(card->host),
> -                               "Card stuck in wrong state! %s status: %#x\n",
> -                                __func__, status);
> -                       return -ETIMEDOUT;
> -               }
> -
> -               /*
> -                * Some cards mishandle the status bits,
> -                * so make sure to check both the busy
> -                * indication and the card state.
> -                */
> -       } while (!mmc_blk_in_tran_state(status));
> -
> -       return err;
> -}
> -
>  static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
>                          int type)
>  {
> --
> 2.18.0
>
