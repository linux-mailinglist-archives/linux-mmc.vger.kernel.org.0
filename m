Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC61F16E
	for <lists+linux-mmc@lfdr.de>; Wed, 15 May 2019 13:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbfEOLyC (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 May 2019 07:54:02 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40147 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbfEOLxx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2019 07:53:53 -0400
Received: by mail-vk1-f194.google.com with SMTP id v140so666609vkd.7
        for <linux-mmc@vger.kernel.org>; Wed, 15 May 2019 04:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqTiQWMIUKTMvV3HGe2FXr2QXLkNPTKOj2lPv0DODS0=;
        b=L44WaYKFencKFL0aLRS4NaNaiepcTeSneyqE/eagATEjv28G/XY8rdrsINJYIQTZ92
         +PAtHPEVh8jR6qiTWKFFfSP1YkX7lU1GpVic60govDCk0GD9r4cJ91O5J6R1ASoGkJiU
         pwD0pXq8TRFRlQS5+wFTsIeGJMUFygr0Z/efTjq8sjfpv/HlMMDxuYSkqsFMm5CRpwm1
         HLqUJbTGo7MXb67aLZ0NYqUVwWM/iGnfiWnM954ZKFJk9wjWdFEtfhfXNzRPB2YT4cX3
         77AwPyaxeHAs+IgiexzVRguxuEPOP+ojlb2p4XdTHLUFutHRjAJsb04tpSMsrNmvvuQP
         EpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqTiQWMIUKTMvV3HGe2FXr2QXLkNPTKOj2lPv0DODS0=;
        b=qsKEWzQryI+P90mGQektTFbCtMgvJsFGej2z4UZLsFWSCOxkMO1dwBVoYrDnk3Jsi+
         5lLCI+wUgQ2BFP/FwVmBiVI1kIJKcxBZwjqsrrg3eZI1M1+wnowowyrdL8DZeKELKFHi
         SC1l0IRh5R0xvKkdpi11ufQPawcX6jZu8RfR2f6iPxbLEmPC4cO/TVsaFR7G4CZCbXo0
         c86f/TtSb/vxYs+eAGWQlksq/HeYr/oLknYKK0fGxePRSHiqtQTm6VCs5N8jGbZh+C7K
         5UQgddr5NIvjxndtDoNxdNRrMOS3VPqgAkkCHimiyV9+TBFPgPYzAcilgKktFJlKn6Nx
         bcMQ==
X-Gm-Message-State: APjAAAUs/cJxevJ8KmVgULoiISxYbAwCriaY6A/qp+LMmHTdvE/9Dfd1
        vc0xTBCo1h6fNjR2IObIyLh2EcQxcVsKxWcQiIQrnQ==
X-Google-Smtp-Source: APXvYqxLLXp4CbKZ5K2cHxrvSLCedDsciD24l4vc3t7NCOi6h5PckPFbTpLuj6YsLGx3RyREW/4BoB33n9It563S1oQ=
X-Received: by 2002:a1f:6e4d:: with SMTP id j74mr888394vkc.36.1557921232169;
 Wed, 15 May 2019 04:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190509172427.17835-1-scott.branden@broadcom.com>
In-Reply-To: <20190509172427.17835-1-scott.branden@broadcom.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 May 2019 13:53:16 +0200
Message-ID: <CAPDyKFrmTEkknnmU22xuKaoG1=SbU2MfQANPmtV0wcF1xKaguA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-iproc: fixes for HS50 data hold time
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 9 May 2019 at 19:24, Scott Branden <scott.branden@broadcom.com> wrote:
>
> This patch series fixes data hold timing issues for various sdhci-iproc
> ip blocks that do not meet the HS50 data hold time.  NO_HISPD bit is set
> in quirks.
>
> Changes from v2:
>  - Added info to commit message as to stable tag selection decision
>    as per Adrian Hunter
>
> Changes from v1:
>  - Change fixes tag to Cc: stable@vger.kernel.org to specify version
>    to backport to
>
> Trac Hoang (2):
>   mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time
>     problem
>   mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem
>
>  drivers/mmc/host/sdhci-iproc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.17.1
>

Applied for fixes, thanks!

Kind regards
Uffe
