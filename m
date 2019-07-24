Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2992973125
	for <lists+linux-mmc@lfdr.de>; Wed, 24 Jul 2019 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfGXOJH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 24 Jul 2019 10:09:07 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46347 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfGXOJG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jul 2019 10:09:06 -0400
Received: by mail-vk1-f194.google.com with SMTP id b64so9400540vke.13
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2019 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMM/fuc3WiNrMsYpxO4sLYGg6mIGpBm3nkr4euaECOE=;
        b=YyYI649c5rtIY3S/Tov9vJAujEz+ZdfPE1Sit+Zb1USS0ZxO7aYR7HJ7I9gsd7v19n
         fTt5OgOfV9kUpe24n/+4iPaReqQNOfwmyuDlt2QW61jbKZXYd0SLicAkXYEJYpEx+UkO
         e3XlsQ6fZwccPrmcgC7+7UGawS353Gbq6bmEGW8XIeFpSmdu6I2VhWWSZvUF8KaKAxRu
         PgH6adCiv6dA1bkKiWhKX4sIqv6WS9gNNZnYQkgHN7+Uvs7oU8huJ874QLnULSSbYg10
         6RNSmHPLESgkGYtTBdIHaUI0MS0MlG5vP5cYYwhztolUv5drWuE2peVkQw2dAavzIVAb
         QFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMM/fuc3WiNrMsYpxO4sLYGg6mIGpBm3nkr4euaECOE=;
        b=ZUk8gsPKetF0tpww9n6qPvsPANHrvFDAeshRZABkbA4X7vC3jaQCitUwzUTUSo99SU
         FkIoMk07hio2kx2KxBXr4oSG12m1qEj8wfmOHJ7Ref1Z7ndPMUkXr1pHTfyoff7RiNdQ
         wJAmcT4vQw+pEqu4r6I4usCt9gBd3v/sTJ+ulZOLvoxYCndwC8D28jmP71Jf4x6DUX/t
         rVtck/qs3nZW7+Rshck1+Oof0C8L143b0/yQXav8Nvz7tRlyYaccVupOEl7ov6Ni2rhe
         v8HzWDWgAi5eiShb918Wi5wZuQCRdu3mU/AghB4Dy9TKap0XuZGHOJa+3K3kP1pQEUdD
         qJvQ==
X-Gm-Message-State: APjAAAV/avufq0yNaaNckEJIqL+7O5wVK3Mmrt9/cg7xMajeuu4bd8/K
        Hsr8sQmUNUVoD4WyoumXLvi4sR00872dqdaa6kxwtQ==
X-Google-Smtp-Source: APXvYqz6aI9mhe4o48eiASnSqHgsrfHpOq8U3P2uy9ecuXBVqcQYD4NERo0xNJEZjBwrmITSdbMQzAo+udkAzdaIUZU=
X-Received: by 2002:a1f:f282:: with SMTP id q124mr32103246vkh.4.1563977344697;
 Wed, 24 Jul 2019 07:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190723124707.24782-1-hslester96@gmail.com>
In-Reply-To: <20190723124707.24782-1-hslester96@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Jul 2019 16:08:28 +0200
Message-ID: <CAPDyKFpo3P_e1ufxyOLLxdeRLe-z1-1Yx5xERD2Hkf0OQbBh8w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Jul 2019 at 14:47, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 4041878eb0f3..d10aceed5bb7 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1759,8 +1759,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
>  #ifdef CONFIG_PM_SLEEP
>  static int sdhci_pci_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +       struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>
>         if (!chip)
>                 return 0;
> @@ -1773,8 +1772,7 @@ static int sdhci_pci_suspend(struct device *dev)
>
>  static int sdhci_pci_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +       struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>
>         if (!chip)
>                 return 0;
> @@ -1789,8 +1787,7 @@ static int sdhci_pci_resume(struct device *dev)
>  #ifdef CONFIG_PM
>  static int sdhci_pci_runtime_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +       struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>
>         if (!chip)
>                 return 0;
> @@ -1803,8 +1800,7 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
>
>  static int sdhci_pci_runtime_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +       struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>
>         if (!chip)
>                 return 0;
> --
> 2.20.1
>
