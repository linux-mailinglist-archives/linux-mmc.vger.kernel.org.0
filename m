Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655B46B116
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Jul 2019 23:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfGPV0u (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 17:26:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46554 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGPV0u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 17:26:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so21458089ljg.13
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2019 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yel/dvjRFYE+g5Wj0x82G14SgP0GK1TVQpwlRIRRolk=;
        b=exuI1+P2iMAZqFKUjckHCNYdFuJYZClC+M2O8ZJz0C1/jy3kL570oJkP+D46peaQgM
         ZfmriwnTI5qj4RaNASaiugdSeOQCZLiaOlDgSCPwOq9H/6YAQwPIMmIXqXAWxvpIDPDz
         iyciyPD83aQpjBCkTBlbw/CG1QhGLGywD9qry05lswnyvGSAu9fWYtTFNjCcPnbhAFOb
         A0qpgIfI0cKvuPtncf8VHm9uMaMiMGCpEIJ/PEzBUNXb4tWAhSL03F0TaxQ1CQgwqogg
         E7N711/gjb8589hwGp5zePChr5XJz3cclceHR6p4Ad4bH+8/u+2kL3nMOK8vxZ5mOBTx
         DmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yel/dvjRFYE+g5Wj0x82G14SgP0GK1TVQpwlRIRRolk=;
        b=FaUIP1WbLToOvuqQD+Py+7ZVNPLXecJvmsFt/C8/yw6EJarQ1MPi5sdAsQOACD26H9
         zR9MY5B+Aaioy+nceDOkDatQ4OzAY1+saY3OLDGrILOYcgT6bc5qtNEyFPrcbEjK6+vt
         R3Z8i+Yq/IrBLBMgF0oSW2UKgcX+PngLabEqLa7cSXlMErRp0TWcJ1a/zGyPGSmhqUhq
         /S6DUYaXYDQoD/pnokzUQNMGfyJhljg0hOpoNx+j0ALNmVJZ6SALf4/CUrnnysad6OJZ
         xC5fXAFFKnEkpCzdWhRIAYnSa+juTqbD2A5F6HBPS/Twin0/ARw118FlrKPxbRzQVQH5
         X7sw==
X-Gm-Message-State: APjAAAWhxngXTnYZygYapaN1khH7kaUfWpa2pw2NOzuMgC4UH8+COlj4
        fko80CURsax6kLmBnmvpk/7SJvAhRDzKLXJsWXMI5A==
X-Google-Smtp-Source: APXvYqwrY65kEaepRm67/+DyYHWnkpbLbjrxod5G2wwXMxWU0wtGY3vlbBRCyeOIlcJRlzLiQro2gtcZJ2EG52hqJrs=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr18771614ljm.180.1563312408371;
 Tue, 16 Jul 2019 14:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190715164217.27297-1-ulf.hansson@linaro.org>
In-Reply-To: <20190715164217.27297-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Jul 2019 23:26:35 +0200
Message-ID: <CACRpkdZkvy8STLbC_Z_JaTRQY_vEnFsFa2W5Xp-FzX2azjzjSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci: Drop re-read of MMCISTATUS for busy status
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Nicolas Graux <jean-nicolas.graux@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jul 15, 2019 at 6:42 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The MMCISTATUS register is read from the IRQ handler, mmci_irq(). For
> processing, its value is then passed as an in-parameter to mmci_cmd_irq().
>
> When dealing with busy detection, the MMCISTATUS register is being re-read,
> as to retrieve an updated value. However, this operation is likely costing
> more than it benefits, as the value was read only a few cycles ago. For
> this reason, let's simply drop the re-read and use the value from the
> in-parameter instead.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
