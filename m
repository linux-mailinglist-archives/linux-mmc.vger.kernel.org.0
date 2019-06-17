Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8F5480F6
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 13:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfFQLfy (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 07:35:54 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38542 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFQLfx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 07:35:53 -0400
Received: by mail-ua1-f67.google.com with SMTP id j2so3350766uaq.5
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSiRIn8/KzWJIfRtWmRi4dwks1mk+cd4OUJjaju/J/I=;
        b=XuLvMjFn5UybxW9M4ceUMrkH3aYErtBajZLK9JqPIAAOlrYuDYQJzRmEqw9J/TyE/X
         NNVf08gm6qq5AK81rAyVZosocYyZKYkzKL15sG8o+EqS2NoS8JmCYQ10Rm855y9l1255
         kxeGY5egbnUmehhZwBbUt2lI6hB8isd0ZQRD3IPrp08O7eTKcbnDO1/rbnU4kcRB7eFE
         ocbW8RE5O087x5HJ5qF2xG1XKJFFmWcy9+nrblxib9H4ImztSbqqyFWlz9OQqBGR8l+9
         2p/eo1Nk0/Aa26Jhi+NuK2JQMaZ4c9ruc7VRUTTZB/46WgknDnCMP80i8mRpBVG0OB9H
         BUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSiRIn8/KzWJIfRtWmRi4dwks1mk+cd4OUJjaju/J/I=;
        b=qCQ8fn/yCyDzkGSMDHCEOM9kTDvQpjZ+LNojeDlyoMp5o5dbuRL7vXf3etbnR5Zn9A
         xAIRuxsVF39td7po/kmpi0gsfGLtt+oY9ft4wNxxVcRsyhD29gf00TD1bQhBByNBLHsO
         nnu4M8jgwlesB3BVin5CJCVxIRvqzsSBUQElt0yG57p/PXxhW1B5+jZZSQdy+vKsTfzq
         i11+vPgSlqsPYrSXUX8zSMuewOgb/XcigQ4haRA9THWikWehHO6V5mAfpKD8Lr1KcPGt
         hDWtH8FkPOYi2vtpfr/VvyonVi5511NjQbCWbh7A5CK6+cCl2SZPqc3ncIb4ydaPotER
         xoFQ==
X-Gm-Message-State: APjAAAVs07WUPgcFlF0Eq/+ld399vpgWutKvLCkIqfyJZ97BjuqrdTs9
        8pgCbaFYB1+j43UTkoE4PQNfclkd9RoGAXXOvXOwZPQD
X-Google-Smtp-Source: APXvYqzLGaB2U4WUJLwQM7/a18TKjKnjxjo0/yBfsRHsRH6Klq2/tSU2cK0Nijz/+OsMZA6EJXja/UQ8rAUyVbkJ69w=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr7066993uad.15.1560771352771;
 Mon, 17 Jun 2019 04:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190612082531.2652-1-gregkh@linuxfoundation.org>
In-Reply-To: <20190612082531.2652-1-gregkh@linuxfoundation.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 13:35:16 +0200
Message-ID: <CAPDyKFpEiL-FOwmwEaaxxVKHQjhQD++9SAZ5qHaZnug8ypXLpA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: core: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Jun 2019 at 10:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Series applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/debugfs.c  | 56 ++++++-------------------------------
>  drivers/mmc/core/mmc_test.c | 10 +------
>  2 files changed, 9 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index d2275c5a2311..cc3be259bc42 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -230,45 +230,21 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         struct dentry *root;
>
>         root = debugfs_create_dir(mmc_hostname(host), NULL);
> -       if (IS_ERR(root))
> -               /* Don't complain -- debugfs just isn't enabled */
> -               return;
> -       if (!root)
> -               /* Complain -- debugfs is enabled, but it failed to
> -                * create the directory. */
> -               goto err_root;
> -
>         host->debugfs_root = root;
>
> -       if (!debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops))
> -               goto err_node;
> -
> -       if (!debugfs_create_x32("caps", S_IRUSR, root, &host->caps))
> -               goto err_node;
> -
> -       if (!debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2))
> -               goto err_node;
> -
> -       if (!debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
> -                       &mmc_clock_fops))
> -               goto err_node;
> +       debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
> +       debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
> +       debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
> +       debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
> +                           &mmc_clock_fops);
>
>  #ifdef CONFIG_FAIL_MMC_REQUEST
>         if (fail_request)
>                 setup_fault_attr(&fail_default_attr, fail_request);
>         host->fail_mmc_request = fail_default_attr;
> -       if (IS_ERR(fault_create_debugfs_attr("fail_mmc_request",
> -                                            root,
> -                                            &host->fail_mmc_request)))
> -               goto err_node;
> +       fault_create_debugfs_attr("fail_mmc_request", root,
> +                                 &host->fail_mmc_request);
>  #endif
> -       return;
> -
> -err_node:
> -       debugfs_remove_recursive(root);
> -       host->debugfs_root = NULL;
> -err_root:
> -       dev_err(&host->class_dev, "failed to initialize debugfs\n");
>  }
>
>  void mmc_remove_host_debugfs(struct mmc_host *host)
> @@ -285,25 +261,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>                 return;
>
>         root = debugfs_create_dir(mmc_card_id(card), host->debugfs_root);
> -       if (IS_ERR(root))
> -               /* Don't complain -- debugfs just isn't enabled */
> -               return;
> -       if (!root)
> -               /* Complain -- debugfs is enabled, but it failed to
> -                * create the directory. */
> -               goto err;
> -
>         card->debugfs_root = root;
>
> -       if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
> -               goto err;
> -
> -       return;
> -
> -err:
> -       debugfs_remove_recursive(root);
> -       card->debugfs_root = NULL;
> -       dev_err(&card->dev, "failed to initialize debugfs\n");
> +       debugfs_create_x32("state", S_IRUSR, root, &card->state);
>  }
>
>  void mmc_remove_card_debugfs(struct mmc_card *card)
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index b27df2d2b5ae..492dd4596314 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3167,15 +3167,7 @@ static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
>         struct mmc_test_dbgfs_file *df;
>
>         if (card->debugfs_root)
> -               file = debugfs_create_file(name, mode, card->debugfs_root,
> -                       card, fops);
> -
> -       if (IS_ERR_OR_NULL(file)) {
> -               dev_err(&card->dev,
> -                       "Can't create %s. Perhaps debugfs is disabled.\n",
> -                       name);
> -               return -ENODEV;
> -       }
> +               debugfs_create_file(name, mode, card->debugfs_root, card, fops);
>
>         df = kmalloc(sizeof(*df), GFP_KERNEL);
>         if (!df) {
> --
> 2.22.0
>
