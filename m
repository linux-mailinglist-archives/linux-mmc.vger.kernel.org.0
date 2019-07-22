Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 562E77014B
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfGVNmY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 09:42:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41514 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfGVNmY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 09:42:24 -0400
Received: by mail-ua1-f65.google.com with SMTP id 34so15311413uar.8
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyYB86RN0dwd4EULEBIRa3DFNYh1x6Mf9BF1tEQUtcc=;
        b=DuO1BvyPUHlTBv8+4qMc5iPAN01crsg/PmFwH9BVFPitVjC7/UQnmGRQU9BxuPXngJ
         5+wLqJwE6tK/yuHuDsPigZg49HK+TSoa3pd+zy8CaF2LAkdWq8779DzdW1DEO38mzD+j
         iUXttNfP62Bxw2edQcUCo5sxPfyWJk0sFlWTMG0k1kUCbJv4TPNDzVsJzjAoBiYPWiTj
         9baHYDk5v5wDE22A57NtIVEGQGayb2lQgSHAst001JYs6kaI5gVcaK8bQcE1JBSs83DZ
         CKxiHd8lS8g2kwPfTE7mIc+cFUaw4VdcfmfOEN8mHH8uDxcJ7JLiHKkqgc0xrpx95Id+
         39Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyYB86RN0dwd4EULEBIRa3DFNYh1x6Mf9BF1tEQUtcc=;
        b=SgE0mrFk4lcM6UHjpCQWqUMv+giVcbqZ0T2voSRgwAq91neJH7btDj+QNzlTMJuGLN
         PFhSgufD5mgGujgW9ZEfBrCtF/DJrfnW3mUsmTmmGY50Ldvdghg4fLj3Dq50LHFoEggQ
         bXkxktltlYQ2o5PPe345KiMcynyHLhxepgYk+0FvmCy6f+MkNyGF7Zo2L6cRc25p2EqW
         basRAuWJ7AGXUYQ6rprjsie5p6G49tGPh9K0MjSZG44uzhGek3vGulr8a8ZdDF1rnYU0
         YmhXwHjPvHrNB8xqbkmt+EI4hXsN5TZin3r6LOquZNmhYk8A8B4nBsblAaiKePwe//np
         yHzw==
X-Gm-Message-State: APjAAAVhENI49IiTzhjJ6JAZVKZ2I4ppxaIHk/6CNV7jZAvEM/AiGzMN
        C2Zm6/q5CEtjkS8xMqcCgeIk1XjgTUVmgnHmCXr5NA==
X-Google-Smtp-Source: APXvYqzEIiTIABeiBw+DkvyOKzYlmedRLJ9DgybTuLxLYm1YWhx6yJte7P1MneNTg+DNylIhmiIEKwH7ZHH6siy6KUs=
X-Received: by 2002:ab0:70b1:: with SMTP id q17mr17349220ual.100.1563802943364;
 Mon, 22 Jul 2019 06:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
In-Reply-To: <7bff392d44bf32e9e762ef6e3b53df0d95c22c91.1563184567.git.baolin.wang@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:41:47 +0200
Message-ID: <CAPDyKFrykZ3TGvHjmf+AYZ=DQB+_HPjMf+s5QWUC+oNHErX=6w@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-sprd: Fix the missing pm_runtime_put_noidle()
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Jul 2019 at 12:00, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> When the SD host controller tries to probe again due to the derferred
> probe mechanism, it will always keep the SD host device as runtime
> resume state due to missing the runtime put operation in error path
> last time.
>
> Thus add the pm_runtime_put_noidle() in error path to make the PM runtime
> counter balance, which can make the SD host device's PM runtime work well.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied for fixes and by adding a fixes/stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 6ee340a..603a5d9 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -624,6 +624,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         sdhci_cleanup_host(host);
>
>  pm_runtime_disable:
> +       pm_runtime_put_noidle(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_set_suspended(&pdev->dev);
>
> --
> 1.7.9.5
>
