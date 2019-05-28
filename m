Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34DD2C1C5
	for <lists+linux-mmc@lfdr.de>; Tue, 28 May 2019 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfE1Ixo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 May 2019 04:53:44 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41258 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfE1Ixo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2019 04:53:44 -0400
Received: by mail-vs1-f65.google.com with SMTP id w19so12273517vsw.8
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2019 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK8sXLOpeE59ctJhIGQXI4PJ5csZ63YIoouIc8eVvlQ=;
        b=beeOLpTn6dEhGK2x2cOMzIlqsqMvmIskU+3zj2td/JAHweIkHwsGSOCuZ2BNtShVfW
         ojZm7JltVswNRjQrAyyhfogLUUUc/ypyLH+b6mvmTaYJf3yHfg452kPBxC3xwy44Ykkx
         XAUSRhvsanhr7cF/pVFTLi/ZejG8/qqlZp/qAceW8f0EC/SC2EFuAdGW0PbA+ncE5FLh
         rGkfa69HeX3u9vEOqx+OR51Eta3WKyGDU1kSbvz9qM6gL83lg97Iy0iUJ17NZMrf11p8
         a4XoSPbOLSAtI2oaV/Ro21bq29xyMTNT0bUfv9JW0b6dcvLgdj160wj3r/8L99ZaWbRr
         UwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK8sXLOpeE59ctJhIGQXI4PJ5csZ63YIoouIc8eVvlQ=;
        b=ApOjYsHeqEwUP/yrPeMBOCbJfE3be6jw775CiAiW3NM814z1oC4z3HAM3KQJ1pB8+p
         yUrZtw7AMNgzEpCcAuAYlUa9HcvEgUes4pozMt9sKrro9DFaEQ+acycm18FVbE70QUmq
         fKKnZVaGkrY1LrUdEK48LboRCvZ36XTJrN4UcIAjAjD5q5fbuWiJqcT3DUF7oADjd6f1
         saLD/mevPXA0rVDLb/kfLphi4qdUoQzMdWa+nnYH3w2EnZHeJQjFKFJX1k9f0bEVFfik
         PJ3KN4YzIPUGzkj3+DpArhAnsgHcrGJ6CEktLQRi7KsymNeUxvtKH6HSIlY2YSKgVtRg
         youw==
X-Gm-Message-State: APjAAAUc4ZzRq5S6wq8YKnsIY0j7zyb6vgSG49k7P73ZtqCrwbCH8Grw
        oGw6seZ34yDdQ8kbG79+sn+K/cgDLQMbSd4zPEsFSA==
X-Google-Smtp-Source: APXvYqyV42QW96AtdeRCcdHraepjNDakDyDlAXtMCzOqU39H7gTnczCehB508e06zRvxSR8sret8bHhLSi04YwV/s5I=
X-Received: by 2002:a67:d815:: with SMTP id e21mr45786479vsj.35.1559033623410;
 Tue, 28 May 2019 01:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143647.2503-1-narmstrong@baylibre.com>
In-Reply-To: <20190520143647.2503-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 10:53:07 +0200
Message-ID: <CAPDyKFoOHnYiYogjogRr=7PBjqHOseDDS6L0eirTo7Y+F449ow@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: meson: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 May 2019 at 16:36, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Update the SPDX Licence identifier for the Amlogic MMC drivers.
>
> Neil Armstrong (2):
>   mmc: meson-gx-mmc: update with SPDX Licence identifier
>   mmc: meson-mx-sdio: update with SPDX Licence identifier
>
>  drivers/mmc/host/meson-gx-mmc.c  | 15 +--------------
>  drivers/mmc/host/meson-mx-sdio.c |  6 +-----
>  2 files changed, 2 insertions(+), 19 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
