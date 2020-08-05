Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D323C60D
	for <lists+linux-mmc@lfdr.de>; Wed,  5 Aug 2020 08:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgHEGgM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 5 Aug 2020 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgHEGgH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:36:07 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D364DC06174A
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:36:06 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 125so8125924vsg.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=adHOuChV0ln7Qcii+VypbIa4tc9bbGRg/egclcdTY6M=;
        b=UKCTKQ6Rf+44txRfGkrZLCV7297R2aUCVsx3nWiQXhMF5ZNFWlwcfzZPbLwluhgr3B
         xyn+f8EymF/Qaja5bzd4jwx4DEIy3QlOq4t56DhoPJPaRpVRv+TwSBM5O/FnscoAGDhU
         iP5J8ERLpHHIKwXhXT7yjFb5mNmLYix5/od2SZwGGEBKytmvW2kX4Y+aM84uEeGjzBHi
         cXcWcNV61rGotQH4ZPlE2VuUSeJ2lLIbEyBk5MykGVpPTdSvOk59oKT46elkZG4KdxQk
         Z8gBgpeoZIi3UVehx4D21BLQTXxSF5k2n3DdByts0rhmOEFI+oWeGUvRrN3Og8XMoKfv
         Lv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adHOuChV0ln7Qcii+VypbIa4tc9bbGRg/egclcdTY6M=;
        b=a1ryoLU+UcWWfJNELZ66xaN6mDkqAV4UCbXfpeGtYKNei82O8EEXsRQkjiWpuiBGZ6
         JHvEHekrmE7XnuWJXaNKfYUyZKglzC+uKdnNVgdYZC91DiVlZOFyjAsWGPTdL9dJ6q9a
         pHhg4mzXghjAiI/gmtOm3Ujs4fwm0C3wxRYDuOVPkZi7Z9jsZf4Ml6QfSDTfSb2zo80N
         94tT7L94EjlX3oisTpZOZBlRpOtS7WFDA9rTHQTlhn0892pWgFaR4vSuZIvp1aT6Z8rg
         YZaSCYoPO/ZeOEPIVy8flwLYpdPyaNjHD8491FvW0HpunN8A2t9byPNV5Ahj53cnmVO4
         7r4Q==
X-Gm-Message-State: AOAM533kvfq/1LV19HQ89dq7O2jHpyHO1e9/mg5H6MXajRRCD92ZTyTd
        oxyGZGM/eU6jRnSdPDMenirDKl4EK1e/0XOmslxdEZMCJVS2KQ==
X-Google-Smtp-Source: ABdhPJygrLtiiua0MbANCTFcIQH0r/Qr9GTi8aEdC0lRYfpzc3p2PifXe/dU4I1dY5A2exQdMw8JAuUVMFmI1ZTUi2E=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr882259vso.165.1596609366126;
 Tue, 04 Aug 2020 23:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200715073344.8965-1-benchuanggli@gmail.com>
In-Reply-To: <20200715073344.8965-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:35:28 +0200
Message-ID: <CAPDyKFr70xOEez+u_xiThtudozE6580ydc8_Vp=KVRekSrzNHw@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: Fix a print format for the task descriptor
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Jul 2020 at 09:34, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> The format string of the task descriptor should be "%016llx".
>
> Signed-off-by: Ben Chuang <benchuanggli@gmail.com>

Applied for next (a while ago), thanks!
Kind regards
Uffe



> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index 75934f3c117e..280d64d0b809 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -422,7 +422,7 @@ static void cqhci_prep_task_desc(struct mmc_request *mrq,
>                 CQHCI_BLK_COUNT(mrq->data->blocks) |
>                 CQHCI_BLK_ADDR((u64)mrq->data->blk_addr);
>
> -       pr_debug("%s: cqhci: tag %d task descriptor 0x016%llx\n",
> +       pr_debug("%s: cqhci: tag %d task descriptor 0x%016llx\n",
>                  mmc_hostname(mrq->host), mrq->tag, (unsigned long long)*data);
>  }
>
> --
> 2.27.0
>
