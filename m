Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B36249F68
	for <lists+linux-mmc@lfdr.de>; Tue, 18 Jun 2019 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfFRLl1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 18 Jun 2019 07:41:27 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33440 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbfFRLl0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2019 07:41:26 -0400
Received: by mail-ua1-f66.google.com with SMTP id f20so5597360ual.0
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2019 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KJ/mbtjWxEj5MP1XyOb+hi3sJFxAYeTiBlH7+rKjBw=;
        b=Oj0Jvcy1EjGWCZ2drPqpV8MC8IWxyJsJ5yrszqB5G7ypZWX6xjHSPhq+EmnSEMmBkA
         W5btJYDAus5uYs9mvsazJDQJOn8LtaXdDRedfiVsOErIC86HYpZJ7XMyS63dNkbaCTsW
         D43J3fDMekgVPFtPMmHKqXfhNYXhGtiuFzLoO5LmAf8jsPkZhWiSRzeQ38ooW7v0ssUW
         Grf0qoymC+PLqxcPSr0GIJT2qaJJMRUqKkNNFPl5kJ2Y3tT4NIRVbbZa0GML9zezCcSk
         u9cafd9vWLCZ0faMJi9qoIc+TzTJ9134f/5fM+2j7wFRzf1zIKhVlDTMcVqySMG6/jYm
         JmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KJ/mbtjWxEj5MP1XyOb+hi3sJFxAYeTiBlH7+rKjBw=;
        b=Zw1JkXZs3F9pxgCiVZnOlG/A6zJCz7goXMQvt8d68QovScMFpCZz7taWlL/9JEvuj4
         iulkVSOhe7nvxsQb6MsXwb/6pWUH7rZABMiW2eS+VjcjpJz2LhQzUTPqV4squJH9DCNO
         Fdr1/UfvBRA9SJi0w42aDSHew0ai7PjQWnxYAFc74k2Jw6Pe4nhgimr2hj9ZrC46hS7R
         tyItYCBbLnJ+EId1QjuWxOh4Bgw/pYqqbzwussHSvQg0Veb7dMWsE7E7vCqUdeUZV+od
         w56LN+X72BK1mQ9un57tampP99fFZzisNzkPuJwwHzHVq2dRigBzLjgAMdjy+toF1E3s
         XgCg==
X-Gm-Message-State: APjAAAXr3pwmqr/bXh9a1eNlS6QdHYqLJvE0WFdSuLAWKQ4+46h07l3E
        RIMMfyQB8SaiAZBtGlF8eQduYmRvsCEPUpICEMty4Q==
X-Google-Smtp-Source: APXvYqw6KNkfm7vjNQTJr9tp7fXdM5vH/0wbCaE4rKVXICQx5xxkwwB3IAGJWH/0TtMEK2287zIeLRjxmgLRyElBJrU=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr63582057vsp.35.1560858085439;
 Tue, 18 Jun 2019 04:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190617201014.84503-1-rrangel@chromium.org> <20190617201014.84503-3-rrangel@chromium.org>
In-Reply-To: <20190617201014.84503-3-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Jun 2019 13:40:49 +0200
Message-ID: <CAPDyKFr8=W9PYEYB7DuKisBVZ4nTF5ibJN5_OqoEPPbRURTWtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 Jun 2019 at 22:10, Raul E Rangel <rrangel@chromium.org> wrote:
>
> Remove whitespace in front of SDHCI_CTRL_8BITBUS. The value is not part
> of SDHCI_CTRL_DMA_MASK.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 199712e7adbb3..89fd96596a1f7 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -89,7 +89,7 @@
>  #define   SDHCI_CTRL_ADMA32    0x10
>  #define   SDHCI_CTRL_ADMA64    0x18
>  #define   SDHCI_CTRL_ADMA3     0x18
> -#define   SDHCI_CTRL_8BITBUS   0x20
> +#define  SDHCI_CTRL_8BITBUS    0x20
>  #define  SDHCI_CTRL_CDTEST_INS 0x40
>  #define  SDHCI_CTRL_CDTEST_EN  0x80
>
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
