Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB478711C
	for <lists+linux-mmc@lfdr.de>; Thu, 24 Aug 2023 16:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjHXOIP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 24 Aug 2023 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbjHXOHw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 10:07:52 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76B610FE
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 07:07:44 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-796d78b3f68so2270407241.0
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692886064; x=1693490864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nubETBtS1dSMDEJwWh8wDc13qNb3ZnI/Mhe6CDKWUrY=;
        b=NDBBXis0GAqmpnhGcmqetzvHRk95k4JKV94ty/pUhLVbOloUBxQYr6ACZU7+U8noVR
         gZT+t6qPDRPXoXbFz6ftt7wMu7K3zk57zdbLsMVHLy+bU6UijdY94FfDbIVUIAMlPPoc
         iW8vVCSAOrzxMA8bZcze96fJObEiKDjNMZzYO8Knu3YzV6hSOo7lOk4ng5mhRZ0AaAY9
         AepZ0+vOq2rYi6EdpG4BaDRGfUFTmYTJVgVFXJ3SRFhtrvN2q1CPYmZIR23AlAeTTLjk
         tiVSvAavhpwAL/nq/v1a9HQUNZuj4E35rKow8gIs7CID/qadF/0BSsh3ZcwJDlNJTWLO
         +kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886064; x=1693490864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nubETBtS1dSMDEJwWh8wDc13qNb3ZnI/Mhe6CDKWUrY=;
        b=UFJZO6uMfy6o/rLoRvhpggZujVK/nAEKUEk/06VdQlRYqE3BydU4279F6LHyK3aBx2
         qiSLq1vMWGQVS+6vjSIaoiZ0tw0QF34+njyyvBJcve+juGtPqL0VnXMNVePue9YKjbQI
         8f8Zd8rgFEc3FUxggP8Y6m7ulz6Upygb+6GNnXR5jrYZqgHhXYh241j5aEYo0L7/vjFG
         KmZJf2pZtmJ3zV06gd4wtvuDnnw3SPomT5SPq0ArIK3ct7qY2OCLzgtqQ6O4+8DQ/kUS
         Xdlm6sH5pTQrTE9EwY8JztmhcTE4LTQvJtw0jsklR7CFAyPhcEyIAJ0buXuYzWiWbbN3
         /U5A==
X-Gm-Message-State: AOJu0YwrG4zK1cIAIks4bGgFx79gtDNdQULG7YzD5rI8RBVfGDJ6ZzNP
        /CES5ep4dG22/1awDzvMbOefEpKiO2A/q+K2/AqbEQ==
X-Google-Smtp-Source: AGHT+IFi8WE8IuqIkp3xscE8hBCweptvFoLBwE4VDIDacVQuEjD3TVXgS17/HTbfVwoLKABmUudE1m0H55XNC6Bzio0=
X-Received: by 2002:a05:6102:7b0:b0:44d:55a4:227a with SMTP id
 x16-20020a05610207b000b0044d55a4227amr9065006vsg.14.1692886063858; Thu, 24
 Aug 2023 07:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
 <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com> <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
 <CAFA6WYNPViMs=3cbNsEdhqnjNOUCsHE_8uqiDTzwCKDNNiDkCw@mail.gmail.com>
 <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com>
 <CAC_iWjKKap47PhiCi=BfPZC_wJhVDB10WSf9oWMgdwSgWCfO_A@mail.gmail.com>
 <CAFA6WYMPsBUutjKrm+6qTNHpVr80K2GcSLoYa+MFE3CfLSo8ew@mail.gmail.com>
 <226aa02d-1247-a42c-123d-1c86b6b43d9f@linux.microsoft.com> <CACRpkdb=AnJXG2J_DRsN-RUEh=7_eAs8+_CxPYuueVM0c=DP3Q@mail.gmail.com>
In-Reply-To: <CACRpkdb=AnJXG2J_DRsN-RUEh=7_eAs8+_CxPYuueVM0c=DP3Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 24 Aug 2023 19:37:32 +0530
Message-ID: <CAFA6WYNzLj3ZGj0MP_8n-9ZsMrHs+nFyd11XTARTUXHv4gFs3Q@mail.gmail.com>
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-scsi@vger.kernel.org,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Aug 2023 at 13:34, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Tue, Aug 22, 2023 at 9:07=E2=80=AFPM Shyam Saini
> <shyamsaini@linux.microsoft.com> wrote:
>
> > do we plan to disable access to RPMB devices, once we have this RPMB
> > driver in place. User space tools like mmc-utils/nvme/ufs utils
> > can still access RPMB and programme the key and should
> > RPMB driver deny access to RPMB ?
>
> We don't break userspace. Just not. This is not an option.
>
> The RPMB subsystem simply has to provide the rpmb character
> device the same way the MMC subsystem did, or provide an
> in-kernel backend to the MMC subsystem so that it can provide
> the same device. Whatever solution is best.
>
> No deprecation and deletion and breaking userspace. Ever.
>

Agree, that's the golden rule of thumb we follow in kernel
development. Also, we still need to allow cases where trusted
provisioning user-space tools can program OP-TEE RPMB key during
factory provisioning. And once that is provisioned, I don't think
there is much harm in still exposing the RPMB device to user-space
since it can't do anything malicious without access to OP-TEE RPMB
key.

-Sumit

> Yours,
> Linus Walleij
