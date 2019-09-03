Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B335A6C96
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 17:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfICPLQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 11:11:16 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37476 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfICPLQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 11:11:16 -0400
Received: by mail-vk1-f196.google.com with SMTP id v78so929854vke.4
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTI0NZTU0/mFxSPvZUWUPqu0ACSeySOfVCxQEfIqijc=;
        b=OdL+lK9kuoptcN5+/8c+oMygacRx2h4VnB4fUqNoOvxyquvv8MZEbyZZzZ6KQLdsWT
         3nyA9m15cg/w/4OylY1kLgPjctKPywPLB19WZA7+Jpb/uFva3I0WKoO/9KG/ae3yNdj5
         KoksrpLGB0eZXHZMqT4Psc83m0TqSO6Gs1sLGoSh9An9rKSI1bjqs4UiZO0Xtr0yVAsb
         hagZz3xWQ/Ee1o+lz1v++jLV0dhXWszjdJeltlAcSnrQ7wc/8cZBvLaEwVE7/JvZEmXi
         kVDtxi9VHEC+eXUHdVCBdXEnX40WFkKJGLkITnkHDL1RmDsh4gSKkzSTNj0ZFlL4wN3l
         sgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTI0NZTU0/mFxSPvZUWUPqu0ACSeySOfVCxQEfIqijc=;
        b=aSEosyVuRMlqX/iSsT4cnDv7ipVdUj17b36mGZX+ulCM3ijYdttpJZxHS9E1D3DhDt
         lWO5+ZhhpvpwEHdmD9bQ8KWVwPCf/Ag1/mFwmoiW6fvvoWCYpa3lUT33sZu35eSLjvXU
         J/eCqmEJxxPZI3CWCe3TdtVq1260P150++8b3SkMcmJOukibBS/i3JirF2bdP//2JYZi
         iFom6OJMULPwh7sepixSgMGpEAGI71gCEW3f2q8KgtIA4dUfyikMovvxPxMOtznFRLXZ
         RV5s93vN6PCPLLDIcsvHiU1RuhauMP/wGWzlNSaic220Hrq3z2fAD9/uwfsl8JhBmuFR
         ORVw==
X-Gm-Message-State: APjAAAWxtk3Fd3QDeBuoEBV4LbdmYuQSo5d/5NFNwYBtd8sDNcBdJnXN
        X+QZ3Xm4i4JaNxJY+83w7TbGEgVxeYecszVwFbUSwCxN
X-Google-Smtp-Source: APXvYqyfu+SYDyX7MV+eTIbDoQhXQ8IkJmW9QxOqE6OqVSr2qydrGReCxDej9HDt0/XwmllvRqh9+uJBikGfl92ius0=
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr598623vkb.4.1567523474871;
 Tue, 03 Sep 2019 08:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190830143916.21793-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190830143916.21793-1-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Sep 2019 17:10:39 +0200
Message-ID: <CAPDyKFraTb+wjCdS2O44zW-+u7yXMZDd+5Y3R+VQmzaGTbjxvw@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: mmc_spi: Convert to use for_each_sg()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Aug 2019 at 16:39, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use for_each_sg() macro instead of open coded variant.
>
> No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 19544b121276..66e354d51ee9 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -891,7 +891,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>         /* Handle scatterlist segments one at a time, with synch for
>          * each 512-byte block
>          */
> -       for (sg = data->sg, n_sg = data->sg_len; n_sg; n_sg--, sg++) {
> +       for_each_sg(data->sg, sg, data->sg_len, n_sg) {
>                 int                     status = 0;
>                 dma_addr_t              dma_addr = 0;
>                 void                    *kmap_addr;
> --
> 2.23.0.rc1
>
