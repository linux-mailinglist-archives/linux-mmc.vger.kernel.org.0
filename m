Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00019E1E04
	for <lists+linux-mmc@lfdr.de>; Wed, 23 Oct 2019 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391072AbfJWOWE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 23 Oct 2019 10:22:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:17517 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJWOWD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2019 10:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1571840521;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=4vLgsN6RbRzedKIzquMpNM2ncOlDpPB+Smka4HKMEXs=;
        b=ab5bylqN22dxY9kviuulMD+5iSmQe2FhsPHAQuxblZbFZiZJQZeF+6a59xUq0tR7lZ
        1Oa+okpxN58avMX9Uf960LB4etVXkzhPrNmSe5oXUfa7j8Wr/FGlem5BgKANyaml70b+
        bCGsB1zAf9gVcIKX0geEuI+cuawowwocsQs2ASTbadg+rFEQHy/7lCQh5B+kUQt0bwKe
        e1QtkDiAdOEYQyeAs0U1bSyA7qa0MbCVKv/1iZjgGW3HqsfVRuVrU3tG9hKnjw6S5cIJ
        rj7oL/eU8CyEOduyfIRzISfvqi/fTwrD1PGQWjENi0sGDIfU3fKPB2o0Cl4QDLAtKtZa
        vvSA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWZ5grphlic4MXDJs3VGLK6t/vDxAYt7W8HwvHU="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:8189:4baa:25fa:a65:e9dc:c66a]
        by smtp.strato.de (RZmta 44.28.1 AUTH)
        with ESMTPSA id 60869dv9NEKhlnb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 23 Oct 2019 16:20:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Onboard SD card doesn't work anymore after the 'mmc-v5.4-2' updates
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <87muds586t.fsf@mpe.ellerman.id.au>
Date:   Wed, 23 Oct 2019 16:20:42 +0200
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, Christian Zigotzky <info@xenosoft.de>,
        "contact@a-eon.com" <contact@a-eon.com>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD53973C-4491-4114-9CEE-81F516EF6249@xenosoft.de>
References: <7b549219-a2e1-08c7-331b-9c3e4fdb8a8f@xenosoft.de> <3aeae0d8-e9be-2585-cbbd-70263cb495f1@xenosoft.de> <20191015125105.GU25745@shell.armlinux.org.uk> <5611f3bc-68aa-78ec-182a-1cb414202314@xenosoft.de> <20191015131750.GV25745@shell.armlinux.org.uk> <87muds586t.fsf@mpe.ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

The patch below works. I compiled the RC4 of kernel 5.4 with this patch toda=
y and the onboard SD card works without any problems.

Thanks!

Christian

> On 23. Oct 2019, at 07:42, Michael Ellerman <mpe@ellerman.id.au> wrote:
>=20
> Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
>>> On Tue, Oct 15, 2019 at 03:12:49PM +0200, Christian Zigotzky wrote:
>>> Hello Russell,
>>>=20
>>> You asked me about "dma-coherent" in the Cyrus device tree. Unfortunatel=
y I
>>> don't find the property "dma-coherent" in the dtb source files.
>>>=20
>>> Output of "fdtdump cyrus_p5020_eth_poweroff.dtb | grep dma":
>>>=20
>>> dma0 =3D "/soc@ffe000000/dma@100300";
>>>         dma1 =3D "/soc@ffe000000/dma@101300";
>>>         dma@100300 {
>>>             compatible =3D "fsl,eloplus-dma";
>>>             dma-channel@0 {
>>>                 compatible =3D "fsl,eloplus-dma-channel";
>>>             dma-channel@80 {
>>>                 compatible =3D "fsl,eloplus-dma-channel";
>>>             dma-channel@100 {
>>>                 compatible =3D "fsl,eloplus-dma-channel";
>>>             dma-channel@180 {
>>>                 compatible =3D "fsl,eloplus-dma-channel";
>>>         dma@101300 {
>>>             compatible =3D "fsl,eloplus-dma";
>>>             dma-channel@0 {
>>>                 compatible =3D "fsl,eloplus-dma-channel";
>>>             dma-channel@80 {
>>>                 compatible =3D "fsl,eloplus-dma-channel";
>>>             dma-channel@100 {
>>>                 compatible =3D "fsl,eloplus-dma-channel";
>>>             dma-channel@180 {
>>>                 compatible =3D "fsl,eloplus-dma-channel";
>>=20
>> Hmm, so it looks like PowerPC doesn't mark devices that are dma
>> coherent with a property that describes them as such.
>>=20
>> I think this opens a wider question - what should of_dma_is_coherent()
>> return for PowerPC?  It seems right now that it returns false for
>> devices that are DMA coherent, which seems to me to be a recipe for
>> future mistakes.
>=20
> Right, it seems of_dma_is_coherent() has baked in the assumption that
> devices are non-coherent unless explicitly marked as coherent.
>=20
> Which is wrong on all or at least most existing powerpc systems
> according to Ben.
>=20
>> Any ideas from the PPC maintainers?
>=20
> Fixing it at the source seems like the best option to prevent future
> breakage.
>=20
> So I guess that would mean making of_dma_is_coherent() return true/false
> based on CONFIG_NOT_COHERENT_CACHE on powerpc.
>=20
> We could do it like below, which would still allow the dma-coherent
> property to work if it ever makes sense on a future powerpc platform.
>=20
> I don't really know any of this embedded stuff well, so happy to take
> other suggestions on how to handle this mess.
>=20
> cheers
>=20
>=20
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setu=
p-common.c
> index 25aaa3903000..b96c9010acb6 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -760,6 +760,22 @@ static int __init check_cache_coherency(void)
> late_initcall(check_cache_coherency);
> #endif /* CONFIG_CHECK_CACHE_COHERENCY */
>=20
> +#ifndef CONFIG_NOT_COHERENT_CACHE
> +/*
> + * For historical reasons powerpc kernels are built with hard wired knowl=
edge of
> + * whether or not DMA accesses are cache coherent. Additionally device tr=
ees on
> + * powerpc do not typically support the dma-coherent property.
> + *
> + * So when we know that DMA is coherent, override arch_of_dma_is_coherent=
() to
> + * tell the drivers/of code that all devices are coherent regardless of w=
hether
> + * they have a dma-coherent property.
> + */
> +bool arch_of_dma_is_coherent(struct device_node *np)
> +{
> +    return true;
> +}
> +#endif
> +
> #ifdef CONFIG_DEBUG_FS
> struct dentry *powerpc_debugfs_root;
> EXPORT_SYMBOL(powerpc_debugfs_root);
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 978427a9d5e6..3a4b2949a322 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -993,6 +993,14 @@ int of_dma_get_range(struct device_node *np, u64 *dma=
_addr, u64 *paddr, u64 *siz
> }
> EXPORT_SYMBOL_GPL(of_dma_get_range);
>=20
> +/*
> + * arch_of_dma_is_coherent - Arch hook to determine if device is coherent=
 for DMA
> + */
> +bool __weak arch_of_dma_is_coherent(struct device_node *np)
> +{
> +    return false;
> +}
> +
> /**
>  * of_dma_is_coherent - Check if device is coherent
>  * @np:    device node
> @@ -1002,8 +1010,12 @@ EXPORT_SYMBOL_GPL(of_dma_get_range);
>  */
> bool of_dma_is_coherent(struct device_node *np)
> {
> -    struct device_node *node =3D of_node_get(np);
> +    struct device_node *node;
> +
> +    if (arch_of_dma_is_coherent(np))
> +        return true;
>=20
> +    np =3D of_node_get(np);
>    while (node) {
>        if (of_property_read_bool(node, "dma-coherent")) {
>            of_node_put(node);
