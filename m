Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93881302C72
	for <lists+linux-mmc@lfdr.de>; Mon, 25 Jan 2021 21:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbhAYUTZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 25 Jan 2021 15:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbhAYUTH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2021 15:19:07 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2F2C061573
        for <linux-mmc@vger.kernel.org>; Mon, 25 Jan 2021 12:18:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y19so29224110iov.2
        for <linux-mmc@vger.kernel.org>; Mon, 25 Jan 2021 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYXv/wFZRyq+FlPUZdvlnm5Gtp7c31gg6fYDez/8oj8=;
        b=OELKLw491QNs3/30f3DpvGIw5ZMY5saX/n4jHRSc5rfn4//Mq+061C63lJYsEwq7We
         P4ocd3aq5MFBF2PlKqju4yF7P5hZX7c2eGpvZwuqqSeSoU6gG9BAN9pWIoPuUzplTIep
         BD6skTKmXKhSVZPl1jRerbjrVEIciGaWznxWvyiMZpErj5P6Y+cjb7i20HZIQS6HEg+a
         GfE3ltauTtB2osCvlzL3x2FGr65oF8aKJf2iPklau8ZkjqStV8e2Cv8wCofQAXT8+zdv
         zM4+t9YrF5ULBKfdkpGElHrbPzq+YMh2xZwqiM5CVLLUtVV9StWfwP5U/+2YvyApk7Cc
         hmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYXv/wFZRyq+FlPUZdvlnm5Gtp7c31gg6fYDez/8oj8=;
        b=lDjnppopNFfSR6tWECQUJjZegUVvyMsYC9o1Q8zafhjl5aXINKFWKExAY8fn41ahvv
         UMK57kOmsTJzaSmyLQ3j179vdQaVxLBUP1so4qcTi0Gl4MDcc275lkSko/OZaiadIGss
         YFMzx9GNV6suvKAv1sZ66EKSZVLMW2zVkLFrsqGGMYdiMyflwXTEeCDDCKptc/cB+GSO
         0OYEWN69POkKmnbeJrp6vL5Gn8FTNcpKTttH2tx+gsAjmfbbe5pK7P0963HjSTxng4L8
         EIKGHog7I7biUhM7LIubNcn1R1uoBAZLZFZjN6clGK/VjCww06inxdIR/HQWvNkhkdzo
         fGmw==
X-Gm-Message-State: AOAM533Y8bq+JloP29nbwh6NdlYt654L1aZAEIxrc7m+pZgOTE2O2zvs
        aQDh/WpIQCAHknt++sRZ4qLJLG+es6btu3b8301edg==
X-Google-Smtp-Source: ABdhPJxpudsxrM44lyXDrh/Zm39qLbQ2YNhJzS6BTx4PGQ2lvGprbUMFq1qSrL+8zgabt8wpxeBxsfrrozxyvh7w2cY=
X-Received: by 2002:a05:6638:35ac:: with SMTP id v44mr2166386jal.103.1611605895544;
 Mon, 25 Jan 2021 12:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20210121082155.111333-1-ebiggers@kernel.org> <20210121082155.111333-3-ebiggers@kernel.org>
In-Reply-To: <20210121082155.111333-3-ebiggers@kernel.org>
From:   Satya Tangirala <satyat@google.com>
Date:   Mon, 25 Jan 2021 12:18:04 -0800
Message-ID: <CAA+FYZfVJRqETCjy2f2N-sikydjhtwQnSkMEQ3v=BDkoHLd_4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: ufs: use devm_blk_ksm_init()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 21, 2021 at 12:23 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Use the new resource-managed variant of blk_ksm_init() so that the UFS
> driver doesn't have to manually call blk_ksm_destroy().
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/scsi/ufs/ufshcd-crypto.c | 9 ++-------
>  drivers/scsi/ufs/ufshcd-crypto.h | 5 -----
>  drivers/scsi/ufs/ufshcd.c        | 1 -
>  3 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
> index 07310b12a5dc8..153dd5765d9ca 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.c
> +++ b/drivers/scsi/ufs/ufshcd-crypto.c
> @@ -179,8 +179,8 @@ int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba)
>         }
>
>         /* The actual number of configurations supported is (CFGC+1) */
> -       err = blk_ksm_init(&hba->ksm,
> -                          hba->crypto_capabilities.config_count + 1);
> +       err = devm_blk_ksm_init(hba->dev, &hba->ksm,
> +                               hba->crypto_capabilities.config_count + 1);
>         if (err)
>                 goto out_free_caps;
>
> @@ -238,8 +238,3 @@ void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>         if (hba->caps & UFSHCD_CAP_CRYPTO)
>                 blk_ksm_register(&hba->ksm, q);
>  }
> -
> -void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
> -{
> -       blk_ksm_destroy(&hba->ksm);
> -}
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
> index d53851be55416..78a58e788dff9 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.h
> +++ b/drivers/scsi/ufs/ufshcd-crypto.h
> @@ -43,8 +43,6 @@ void ufshcd_init_crypto(struct ufs_hba *hba);
>  void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>                                             struct request_queue *q);
>
> -void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba);
> -
>  #else /* CONFIG_SCSI_UFS_CRYPTO */
>
>  static inline void ufshcd_prepare_lrbp_crypto(struct request *rq,
> @@ -69,9 +67,6 @@ static inline void ufshcd_init_crypto(struct ufs_hba *hba) { }
>  static inline void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>                                                 struct request_queue *q) { }
>
> -static inline void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
> -{ }
> -
>  #endif /* CONFIG_SCSI_UFS_CRYPTO */
>
>  #endif /* _UFSHCD_CRYPTO_H */
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index e31d2c5c7b23b..d905c84474c2c 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -9139,7 +9139,6 @@ EXPORT_SYMBOL_GPL(ufshcd_remove);
>   */
>  void ufshcd_dealloc_host(struct ufs_hba *hba)
>  {
> -       ufshcd_crypto_destroy_keyslot_manager(hba);
>         scsi_host_put(hba->host);
>  }
>  EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
> --
> 2.30.0
>
Looks good to me. Please feel free to add
Reviewed-by: Satya Tangirala <satyat@google.com>
