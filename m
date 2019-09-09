Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2F3AE114
	for <lists+linux-mmc@lfdr.de>; Tue, 10 Sep 2019 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfIIWdG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 9 Sep 2019 18:33:06 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45637 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388106AbfIIWdF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2019 18:33:05 -0400
Received: by mail-vs1-f65.google.com with SMTP id s3so9904663vsi.12
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6vf48QEjz8Sz6LLhjmSSSD9RkuuyFccpcd9mtNGMf8=;
        b=bPBDmsaqenLPEt1pVbouKW4aBIyDJuSdenKbkcFvtDSEnThgUxOJEfhX9ZuBx1+Ar+
         SvPPIIHa2+VvpLU0/RiU1ADuWcBI4xYXB2NVEqYPQc0jLqq+kXQ2DDQHYYQGUlCnjkEp
         zv+CWoPz/QdwYLOpGK5xrN2kCw9cY1EWNjvS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6vf48QEjz8Sz6LLhjmSSSD9RkuuyFccpcd9mtNGMf8=;
        b=IEueVY0uVPEGuVN/X3fbr7e9F8Hi8deOKNTQZdnNxnHicWgPc0JRPxKTiqfb687F8s
         /YHb/T7P5KqbIjR/KZegmoidToe4uBv8k+kT4/GzHcdfzoWe4vGheIK9BNjpB1l/IpTx
         XnJDCnSf0vgf0O5go9owaIW2QxRkmxUGdl3ttBftFojzmfx8qISGpwCe7oMA+Mqg8uLC
         s5CzXJXf/gFjYtvw7GLPdviy7jD8aaObGETQjPqYDpHus3BVs9uUPNLk6kRJABQCPtRB
         0mhu5IdOPsBU0BMdwYooWwWhjVnKvfmlXJnaRk+RGJppWdiP6o3PivruJ02SCcD5tqhN
         CIrQ==
X-Gm-Message-State: APjAAAVK/5vps5BPwofXCL+u1Jop+CAth8dg/vuiXGk9TYnX7+H/4bkg
        Z3mVfhsG/rZSMjEci4novNYPIvBuQHo=
X-Google-Smtp-Source: APXvYqw6zmIQ7Jd5QWfLFbg2ymlL/Cee1B3c9UCYeCYWksA6DoEFuzTvTbiJmcJawNeUDPLF8uzHNg==
X-Received: by 2002:a67:2c47:: with SMTP id s68mr14903563vss.4.1568068383978;
        Mon, 09 Sep 2019 15:33:03 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id b207sm6322877vka.12.2019.09.09.15.33.02
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:33:03 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id k12so4874372uan.13
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2019 15:33:02 -0700 (PDT)
X-Received: by 2002:ab0:2eab:: with SMTP id y11mr12640675uay.0.1568068382471;
 Mon, 09 Sep 2019 15:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-5-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-5-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:32:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WhJ_wL181sWUZoKKaQWnZUDkkG=QovJsugsBVOzAOi9Q@mail.gmail.com>
Message-ID: <CAD=FV=WhJ_wL181sWUZoKKaQWnZUDkkG=QovJsugsBVOzAOi9Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] mmc: core: Move code to get pending SDIO IRQs to
 a function
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> To improve code quality, let's move the code that gets pending SDIO IRQs
> from process_sdio_pending_irqs() into a dedicated function.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> [Ulf: Converted function into static]
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 46 ++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 16 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
